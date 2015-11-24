Name     : motd-update
Version  : 1
Release  : 1
Source0  : motd-update.sh
Source1  : motd-update.service
Source2  : motd-update.path
Summary  : Service files for updating message of the day
Group    : Development/Tools
License  : MIT

%description
Update message of the day.

%prep

%build

%install
rm -rf %{buildroot}
install -d -m 0755 %{buildroot}/usr/lib/motd.d
install -d -m 0755 %{buildroot}/etc/motd.d

install -d -m 0755 %{buildroot}/usr/lib/systemd/system
install -d -m 0755 %{buildroot}%{_bindir}
install -m  0744 %{SOURCE0} %{buildroot}%{_bindir}/motd-update.sh
install -m  0644 %{SOURCE1} %{buildroot}/usr/lib/systemd/system/motd-update.service
install -m  0644 %{SOURCE2} %{buildroot}/usr/lib/systemd/system/motd-update.path

install -d -m 0755 %{buildroot}/usr/lib/systemd/system/multi-user.target.wants
ln -s /usr/lib/systemd/system/motd-update.path %{buildroot}/usr/lib/systemd/system/multi-user.target.wants/motd-update.path
ln -s /usr/lib/systemd/system/motd-update.service %{buildroot}/usr/lib/systemd/system/multi-user.target.wants/motd-update.service

%files
%defattr(-,root,root,-)
/usr/lib/systemd/system/motd-update*
/usr/bin/motd-update.sh
/usr/lib/systemd/system/multi-user.target.wants/motd-update.path
/usr/lib/systemd/system/multi-user.target.wants/motd-update.service