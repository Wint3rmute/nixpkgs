{ lib
, buildPythonPackage
, fetchgit
, pythonOlder
, pytestCheckHook
, indexed-bzip2
, indexed-gzip
, indexed-zstd
, python-xz
, rapidgzip
, rarfile
, zstandard     # Python bindings
, zstd          # System tool
}:

buildPythonPackage rec {
  pname = "ratarmountcore";
  version = "0.6.3";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchgit {
    url = "https://github.com/mxmlnkn/ratarmount";
    rev = "core-v${version}";
    hash = "sha256-2jG066BUkhyHRqRyFAucQRJrjXQNw2ccCxERKkltO3Y=";
    fetchSubmodules = true;
  };

  sourceRoot = "${src.name}/core";

  propagatedBuildInputs = [ indexed-gzip indexed-bzip2 indexed-zstd python-xz rapidgzip rarfile ];

  pythonImportsCheck = [ "ratarmountcore" ];

  nativeCheckInputs = [ pytestCheckHook zstandard zstd ];

  meta = with lib; {
    description = "Library for accessing archives by way of indexing";
    homepage = "https://github.com/mxmlnkn/ratarmount/tree/master/core";
    license = licenses.mit;
    maintainers = with lib.maintainers; [ mxmlnkn ];
    platforms = platforms.all;
  };
}
