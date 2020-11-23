self: super: let
  overridePython = python: python.override {
    packageOverrides = pyPkgsSelf: pyPkgsSuper: {
    };
  };

in {
  python3 = overridePython super.python3;
}