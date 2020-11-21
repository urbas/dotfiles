self: super: let
  overridePython = python: python.override {
    packageOverrides = pyPkgsSelf: pyPkgsSuper: {
      coapthon3 = self.callPackage ../pkgs/coapthon3 { pythonPackages = pyPkgsSelf; };
      py-air-control = self.callPackage ../pkgs/py-air-control { pythonPackages = pyPkgsSelf; };
      py-air-control-exporter = self.callPackage ../pkgs/py-air-control-exporter { pythonPackages = pyPkgsSelf; };
    };
  };

in {
  python3 = overridePython super.python3;
}