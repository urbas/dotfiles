{ python3
, fetchFromGitHub
}:
let
  pythonPackages = python3.pkgs;
in
  pythonPackages.buildPythonPackage (with pythonPackages; rec {
    name = "philips-air-purifier";
    version = "0.0.4";
    checkInputs = [ httmock pytest pytestrunner pytestcov ];
    propagatedBuildInputs = [ pycryptodome requests ];
    src = fetchFromGitHub {
      owner = "urbas";
      repo = name;
      rev = "v${version}";
      sha256 = "0h2asb3qd5mzjrv2c40bhrs06qf2sw48qn1xx4xgvc9fd7dw6ql9";
    };
  })
