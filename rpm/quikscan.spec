%define debug_package %{nil}

Name:           quikscan
Version:        0.1
Release:        1%{?dist}
Summary:        A GUI for hp-scan

License:        GPLv3+
URL:            https://github.com/Rudd-O/quikscan
Source0:	Source0: https://github.com/Rudd-O/%{name}/archive/{%version}.tar.gz#/%{name}-%{version}.tar.gz

BuildRequires:  make
BuildArch:	noarch
Requires:       python2, gobject-introspection, gtk3, pygobject3, hplip

%description
quikscan is a GUI frontend for HP's hp-scan scanning tool.

%prep
%setup -q

%build
# variables must be kept in sync with install
make DESTDIR=$RPM_BUILD_ROOT BINDIR=%{_bindir} \
DESKTOPDIR=%{_datadir}/applications \

%install
rm -rf $RPM_BUILD_ROOT
# variables must be kept in sync with build
make install DESTDIR=$RPM_BUILD_ROOT BINDIR=%{_bindir} \
DESKTOPDIR=%{_datadir}/applications \

rm -rf $RPM_BUILD_ROOT/%{_initddir}/

%files
%{_bindir}/quikscan
%{_datadir}/applications/*.desktop

%doc README.md

%changelog
* Wed Mar 15 2017 Manuel Amador (Rudd-O) <rudd-o@rudd-o.com>
- Initial release
