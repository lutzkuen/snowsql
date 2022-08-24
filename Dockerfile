FROM python:3.9.13-slim-buster
RUN pip install jinja2-cli
RUN curl -O https://sfc-repo.azure.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-1.2.19-linux_x86_64.bash
RUN SNOWSQL_DEST=/bin SNOWSQL_LOGIN_SHELL=/root/.profile bash snowsql-1.2.19-linux_x86_64.bash
COPY snowsql.conf .
RUN echo "jinja2 snowsql.conf -D SNOWFLAKE_ACCOUNT=\$SNOWFLAKE_ACCOUNT -D SNOWFLAKE_USER=\$SNOWFLAKE_USER -D SNOWFLAKE_DATABASE=\$SNOWFLAKE_DATABASE -D SNOWFLAKE_WAREHOUSE=\$SNOWFLAKE_WAREHOUSE -D SNOWFLAKE_SCHEMA=\$SNOWFLAKE_SCHEMA -D SNOWFLAKE_PASSWORD=\$SNOWFLAKE_PASSWORD > /root/.snowsql/config" > root/.bashrc
CMD ["bash"]