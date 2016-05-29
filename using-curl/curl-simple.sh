#!/bin/bash
echo -n "Testing CDA Event Proxy API..."
curl -v -k -L https://dftapi-stg.cisco.com/dft/cda/event-proxy/echo/test
echo
echo -n "Testing CDA Software Analytics API..."
curl -v -k -L https://dftapi-stg.cisco.com/dft/cda/software/echo/test
echo
echo -n "Testing CDA Developer Analytics API..."
curl -v -k -L https://dftapi-stg.cisco.com/dft/cda/developer/echo/test
echo
echo -n "Testing CDA Platform Analytics API..."
curl -v -k -L https://dftapi-stg.cisco.com/dft/cda/platform/echo/test
echo
echo -n "Testing CD Metadata API..."
curl -v -k -L https://dftapi-stg.cisco.com/dft/cda/software-metadata/echo/test
echo
echo -n "Testing CDA UI Facade API..."
curl -v -k -L https://dftapi-stg.cisco.com/dft/cda/ui-facade/echo/test
echo