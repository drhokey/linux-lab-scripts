Name:           count-files
Version:        2.0
Release:        1%{?dist}
Summary:        Script to count regular files in /etc
License:        MIT
URL:            https://github.com/drhokey/linux-lab-scripts
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       bash
Requires:       coreutils
Requires:       findutils

%description
A Bash script that counts the number of regular files
in the /etc directory, excluding directories and symbolic links.

%prep
%setup -q

%pre
echo "Підготовка до встановлення пакета count-files..."

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_mandir}/man1
mkdir -p %{buildroot}%{_sysconfdir}
install -m 644 count-files.conf %{buildroot}%{_sysconfdir}/count-files.conf
install -m 755 count_files.sh %{buildroot}%{_bindir}/count_files
install -m 644 count_files.1 %{buildroot}%{_mandir}/man1/count_files.1

%post
echo "Пакет count-files успішно встановлено в систему!"
if [ -f /etc/count-files.conf ]; then
    echo "Конфігураційний файл доступний за адресою: /etc/count-files.conf"
fi

%files
%{_bindir}/count_files
%{_mandir}/man1/count_files.1*
%config(noreplace) %{_sysconfdir}/count-files.conf

%changelog
* Mon Oct 27 2026 Kyrylo Salva <drhokey@github.com> - 1.0-1
- Initial package release with man page
* Mon Oct 27 2026 Kyrylo Salva <drhokey@github.com> - 2.0-1
- Released version 2.0 with config support, man page and help option
