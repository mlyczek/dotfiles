#
# Path variables related to java
#

# We want to set the path to JDK. In Debian /usr/bin/javac is a symlink to /etc/alternatives/javac
# which also is a symlink to exact javac binary. The second symlink is managed by alternatives system,
# so instead exporting the full path we read it from this links
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
