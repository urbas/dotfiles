{ fetchFromGitHub
, lib
, pythonPackages }:

pythonPackages.buildPythonPackage (with pythonPackages; rec {
  pname = "py-air-control-exporter";
  version = "0.1.4";

  nativeBuildInputs = [ setuptools_scm ];
  checkInputs = [ pytestCheckHook pytestcov pytestrunner ];
  propagatedBuildInputs = [ flask prometheus_client py-air-control ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "1f13d3mlj6c3xvkclimahx7gpqqn8z56lh4kwy1d3gkjm7zs9zw9";
  };

  meta = with lib; {
    description = "Exports air quality metrics to Prometheus.";
    homepage    = "https://github.com/urbas/${pname}";
    license     = licenses.mit;
    # maintainers = with maintainers; [ urbas ];
  };
})