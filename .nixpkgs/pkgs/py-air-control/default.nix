{ fetchFromGitHub
, lib
, pythonPackages }:

pythonPackages.buildPythonPackage (with pythonPackages; rec {
  pname = "py-air-control";
  version = "2.1.0";

  propagatedBuildInputs = [ pycryptodomex coapthon3 ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "0g9qkaygjyyxkhgx51m8hhj9inlzmynzw6l4vp7g1cflrn8g3i92";
  };

  meta = with lib; {
    description = "Command line app for controlling Philips air purifiers.";
    homepage    = "https://github.com/rgerganov/${pname}";
    license     = licenses.mit;
    # maintainers = with maintainers; [ urbas ];
  };
})