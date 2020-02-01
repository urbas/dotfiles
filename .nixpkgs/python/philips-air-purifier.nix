{ python3
, fetchgit
}:
let
  pythonPackages = python3.pkgs;
in
  pythonPackages.buildPythonPackage (with pythonPackages; rec {
    name = "philips-air-purifier";
    version = "0.1.0";
    checkInputs = [ httmock pytest pytestrunner pytestcov ];
    propagatedBuildInputs = [ pycryptodome requests ];
    src = fetchgit {
      url = "https://github.com/urbas/${name}";
      rev = "687ab3a9a937cc2c672fb6e8059ddac2f55f43b6";
      sha256 = "1ywc4vj5nixs1min8ayvm1qipphhgmsnwz7n4vn3qj0py1m25pk5";
    };
  })
