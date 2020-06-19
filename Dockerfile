FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

ENV PATH_OWASP_EXTRACT /owasp-modsecurity-crs

WORKDIR /tmp/owasp-modsecurity-crs

RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
		ca-certificates \
	    git \
	    curl \
	    tar \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

	# get last number version of tag "refs/tags/vX.X.X" and Download
RUN LAST_VERSION=$(git ls-remote --tags "https://github.com/coreruleset/coreruleset.git" | \
		grep -o '[0-9]\+\.[0-9]\+\.[0-9]$' | \
		sort -n | tail -1 ) \
	&& echo "the last version of OWASP ModSecurity Core Rule Set is : $LAST_VERSION" \
	&& curl -sL https://github.com/coreruleset/coreruleset/archive/v${LAST_VERSION}.tar.gz --output modsec.tar.gz
	# extract
RUN tar -zxf modsec.tar.gz \
	&& mv coreruleset-* $PATH_OWASP_EXTRACT \
	&& cp $PATH_OWASP_EXTRACT/crs-setup.conf.example $PATH_OWASP_EXTRACT/crs-setup.conf