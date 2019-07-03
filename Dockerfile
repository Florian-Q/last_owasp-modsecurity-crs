FROM ubuntu:latest

ENV PATH_OWASP_EXTRACT /owasp-modsecurity-crs

WORKDIR /tmp/owasp-modsecurity-crs

RUN OFFICIAL_DEPO="https://github.com/SpiderLabs/owasp-modsecurity-crs.git" \
	&& apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
		ca-certificates \
	    git \
	    curl \
	    tar \
	# get last number version of tag "refs/tags/vX.X.X"
	&& LAST_VERSION=$(git ls-remote --tags $OFFICIAL_DEPO | \
		grep -o '[0-9]\+\.[0-9]\+\.[0-9]$' | \
		sort -n | tail -1 ) \
	&& echo "the last version of OWASP ModSecurity Core Rule Set is : $LAST_VERSION" \
	# Download and extract
	&& curl -s https://codeload.github.com/SpiderLabs/owasp-modsecurity-crs/tar.gz/v${LAST_VERSION} --output modsec.tar.gz \
	&& tar -zxf modsec.tar.gz \
	&& mv "owasp-modsecurity-crs-$LAST_VERSION" $PATH_OWASP_EXTRACT \