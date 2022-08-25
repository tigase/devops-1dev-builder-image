FROM eclipse-temurin:17

# Setup environment.
ENV GRADLE_HOME="/usr/bin/gradle" \
    MAVEN_HOME="/opt/java/maven" \
    TZ="America/Los_Angeles" \
    JAVA_TOOL_OPTIONS="" \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE="DontWarn"
ENV PATH=${PATH}:/opt/tools:${MAVEN_HOME}/bin

# Install build & util tools. Cleanup in single layer to reduce the size
RUN apt-get -y update \
    && apt-get -y --no-install-recommends install \
        bash-completion bzip2 ca-certificates curl expect file git \
#        gradle \
        gzip less \
#        maven \ #don't install maven using apt-get to avoid pulling java as dependency from repository
        mc \
#        python3 \
        sudo tar unzip vim wget zip \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instal maven
RUN curl "https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip" -o "maven.zip" \
    && unzip -q maven.zip -d /opt/java/ \
    && ln -s /opt/java/apache-maven-3.8.6/  ${MAVEN_HOME} \
    && rm maven.zip

# Instal AWS CLI & ecs-deploy (https://github.com/fabfuel/ecs-deploy)
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip \
    && rm -rf ./aws

#RUN useradd --user-group --system --create-home --no-log-init --shell /bin/bash tigase \
#    && mkdir -p /etc/sudoers.d/ \
#    && usermod -aG sudo tigase && echo "tigase ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/tigase


# Clean up
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apt-get clean
