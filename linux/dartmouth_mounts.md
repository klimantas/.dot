# Mounting Dartmouth Fileservers on Linux

Guide for mounting Dartmouth network fileservers via CIFS on a personal Linux machine.

---

## Overview

| | Jumbo | ThayerFS |
|---|---|---|
| Server | `jumbo.thayer.dartmouth.edu` | `thayerfs.thayer.dartmouth.edu` |
| Share | `jumbo` | `home` |
| Mountpoint | `/mnt/jumbo` | `/mnt/thayerfs` |
| Domain | `KIEWIT` | `KIEWIT` |
| Auth | Kerberos (`krb5`) | Kerberos (`krb5`) |
| Protocol | CIFS | CIFS |

---

## Prerequisites

### 1. Install required packages

```bash
sudo apt install cifs-utils krb5-user gssproxy
```

`gssproxy` is required for the kernel CIFS client to use your Kerberos ticket.
Without it, `sec=krb5` mounts will fail even with a valid ticket.

### 2. Create mountpoints

```bash
sudo mkdir -p /mnt/jumbo
sudo mkdir -p /mnt/thayerfs
```

---

## Mounting

Both servers use Kerberos, so get a ticket first:

```bash
kinit your_netid@KIEWIT.DARTMOUTH.EDU
klist  # verify the ticket is valid
```

### Jumbo

```bash
sudo mount -t cifs //jumbo.thayer.dartmouth.edu/jumbo /mnt/jumbo \
  -o username=your_netid,domain=KIEWIT,sec=krb5
```

### ThayerFS

```bash
sudo mount -t cifs //thayerfs.thayer.dartmouth.edu/home /mnt/thayerfs \
  -o username=your_netid,domain=KIEWIT,sec=krb5
```

### Verify

```bash
ls /mnt/jumbo
ls /mnt/thayerfs
```

---

## Unmounting

```bash
sudo umount /mnt/jumbo
sudo umount /mnt/thayerfs

# If "target is busy":
sudo umount -l /mnt/jumbo
sudo umount -l /mnt/thayerfs
```

---

## Optional: Convenience Setup

### Aliases for quick remounting

Add to `~/.bashrc`:

```bash
alias mountjumbo='sudo mount -t cifs //jumbo.thayer.dartmouth.edu/jumbo /mnt/jumbo -o username=your_netid,domain=KIEWIT,sec=krb5'
alias mountthayerfs='sudo mount -t cifs //thayerfs.thayer.dartmouth.edu/home /mnt/thayerfs -o username=your_netid,domain=KIEWIT,sec=krb5'
```

Then reload:

```bash
source ~/.bashrc
```

Usage:

```bash
kinit your_netid@KIEWIT.DARTMOUTH.EDU
mountjumbo
mountthayerfs
```

### fstab entries (shorthand mount)

Add to `/etc/fstab`:

```
//jumbo.thayer.dartmouth.edu/jumbo       /mnt/jumbo    cifs  username=your_netid,domain=KIEWIT,sec=krb5,noauto,users  0  0
//thayerfs.thayer.dartmouth.edu/home     /mnt/thayerfs cifs  username=your_netid,domain=KIEWIT,sec=krb5,noauto,users  0  0
```

- `noauto` — prevents mount at boot (Kerberos ticket won't exist yet)
- `users` — allows mounting without sudo

After adding to fstab:

```bash
kinit your_netid@KIEWIT.DARTMOUTH.EDU
mount /mnt/jumbo
mount /mnt/thayerfs
```

---

## Troubleshooting

| Error | Likely Cause | Fix |
|---|---|---|
| `Invalid argument` | NFS blocked outside lab subnet | Use CIFS as described above |
| `Permission denied` | Expired or missing Kerberos ticket | Run `kinit` again |
| `No such file or directory` | Wrong share name | Use `jumbo` for Jumbo, `home` for ThayerFS |
| `Device or resource busy` | Mountpoint already in use | Run `sudo umount /mnt/<mountpoint>` first |
| `Connection refused` | Not on Dartmouth network | Connect to campus network or VPN |

---

## Notes

- NFS mounts work on lab machines (subnet `10.81.x.x`) but are blocked for personal machines on other subnets (e.g. `10.28.x.x`). Use CIFS instead.
- Kerberos tickets typically expire after 10 hours. Run `kinit` again and remount after expiry.
- macOS equivalents: `smb://KIEWIT;your_netid@jumbo.thayer.dartmouth.edu/jumbo` and `smb://KIEWIT;your_netid@thayerfs.thayer.dartmouth.edu/home`.
