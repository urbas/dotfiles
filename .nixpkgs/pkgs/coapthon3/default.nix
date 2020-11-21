{ fetchFromGitHub
, lib
, pythonPackages }:

pythonPackages.buildPythonPackage (with pythonPackages; rec {
  pname = "CoAPthon3";
  version = "1.0.1";

  propagatedBuildInputs = [ cachetools ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "1w6bwwd3qjp4b4fscagqg9wqxpdgvf4sxgzbk2d2rjqwlkyr1lnx";
  };

  meta = with lib; {
    description = "CoAPthon3 is a python3 library to the CoAP protocol compliant with the RFC.";
    homepage    = "https://github.com/Tanganelli/${pname}";
    license     = licenses.mit;
    # maintainers = with maintainers; [ urbas ];
  };
})