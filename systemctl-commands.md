## Command	Purpose
systemctl start mysqld   -->	Start MySQL now
systemctl stop mysqld	--> Stop MySQL now
systemctl restart mysqld -->	Restart MySQL
systemctl status mysqld	--> Check service status
systemctl enable mysqld	--> Start automatically at boot
systemctl disable mysqld -->	Do not start automatically at boot

# Service Management:

Start a service.
```
systemctl start <service>
```
Stop a service.
```
systemctl stop <service>
```
Restart a service.
```
systemctl restart <service>
```
Reload configuration without restarting (if supported).
```
systemctl reload <service>
```
Reload if possible; otherwise restart.
```
systemctl reload-or-restart <service>
```
Restart only if the service is already running.
```
systemctl try-restart <service>
```

## Service Status
View detailed status.
```
systemctl status <service>
```
Check if a service is running.
```
systemctl is-active <service>
```
Check if a service has failed.
```
systemctl is-failed <service>
```
Check if a service starts automatically at boot.
```
systemctl is-enabled <service>
```

## Boot-Time Management
Enable automatic startup at boot.
```
systemctl enable <service>
```
Disable automatic startup.
```
systemctl disable <service>
```
Disable and then enable a service.
```
systemctl reenable <service>
```
Apply the system's default enable/disable policy.
```
systemctl preset <service>
```

## Masking Services:
Prevent a service from being started manually or automatically.
```
systemctl mask <service>
```
Remove the mask.
```
systemctl unmask <service>
```

Listing Services:
List active units.
```
systemctl list-units
```
List active services.
```
systemctl list-units --type=service
```
List all installed unit files.
```
systemctl list-unit-files
```
List all service unit files.
```
systemctl list-unit-files --type=service
```
Show failed units.
```
systemctl --failed
```

# Viewing Configuration
Show the service unit file.
```
systemctl cat <service>
```
Display all service properties.
```
systemctl show <service>
```
Create or modify a service override.
```
systemctl edit <service>
```

# System Management:
Reload systemd configuration after changing unit files.
```
systemctl daemon-reload
```
Re-execute the systemd manager.
```
systemctl daemon-reexec
```
Reboot the system.
```
systemctl reboot
```
Shut down the system.
```
systemctl poweroff
```
Halt the system.
```
systemctl halt
```
Suspend the system.
```
systemctl suspend
```
Hibernate the system
```
systemctl hibernate
```

Targets (Run Levels):
Show the default boot target.
```
systemctl get-default
```
Set text-mode boot.
```
systemctl set-default multi-user.target
```
Set GUI boot.
```
systemctl set-default graphical.target
```

Switch immediately to a target.
```
systemctl isolate multi-user.target
```

# Useful Troubleshooting Commands
View logs for a service.
```
journalctl -u <service>
```
View recent system errors.
```
journalctl -xe
```
Show full service status without truncation.
```
systemctl status <service> -l
```
Show service dependencies.
```
systemctl list-dependencies <service>
```