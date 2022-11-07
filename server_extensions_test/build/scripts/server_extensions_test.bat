@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  server_extensions_test startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and SERVER_EXTENSIONS_TEST_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\batm_server_extensions_test.jar;%APP_HOME%\lib\batm_server_extensions_extra.jar;%APP_HOME%\lib\batm_server_extensions_api.jar;%APP_HOME%\lib\jopt-simple-4.9.jar;%APP_HOME%\lib\slf4j-simple-1.7.25.jar;%APP_HOME%\lib\currencies-1.0.65.jar;%APP_HOME%\lib\xchange-bitfinex-5.0.10.jar;%APP_HOME%\lib\xchange-binance-5.0.12.jar;%APP_HOME%\lib\xchange-bittrex-5.0.10.jar;%APP_HOME%\lib\xchange-bitstamp-5.0.13.jar;%APP_HOME%\lib\xchange-hitbtc-5.0.10.jar;%APP_HOME%\lib\xchange-dvchain-5.0.10.jar;%APP_HOME%\lib\xchange-coinbasepro-5.0.10.jar;%APP_HOME%\lib\xchange-coingi-5.0.10.jar;%APP_HOME%\lib\xchange-enigma-5.0.10.jar;%APP_HOME%\lib\xchange-ftx-5.0.13.jar;%APP_HOME%\lib\xchange-poloniex-5.0.10.jar;%APP_HOME%\lib\xchange-core-5.0.10.jar;%APP_HOME%\lib\bitrafael-client-1.0.44.jar;%APP_HOME%\lib\rescu-2.1.0.jar;%APP_HOME%\lib\core-4.9.0.jar;%APP_HOME%\lib\crypto-4.9.0.jar;%APP_HOME%\lib\Java-WebSocket-1.5.2.jar;%APP_HOME%\lib\xrpl4j-keypairs-2.1.0.jar;%APP_HOME%\lib\xrpl4j-address-codec-2.1.0.jar;%APP_HOME%\lib\xrpl4j-model-2.1.0.jar;%APP_HOME%\lib\libdohj-a2a37e454e5cd02f664ca119ab8b59dfddc75590.jar;%APP_HOME%\lib\bitcoinj-core-0.16.1.jar;%APP_HOME%\lib\resilience4j-all-1.7.0.jar;%APP_HOME%\lib\client-5.5.0.jar;%APP_HOME%\lib\jackson-dataformat-hal-1.0.4.jar;%APP_HOME%\lib\litecoinj-0.15.1.20190418.jar;%APP_HOME%\lib\dashj-core-0.15.2.20190416.jar;%APP_HOME%\lib\resilience4j-ratelimiter-1.7.0.jar;%APP_HOME%\lib\resilience4j-circuitbreaker-1.7.0.jar;%APP_HOME%\lib\resilience4j-bulkhead-1.7.0.jar;%APP_HOME%\lib\resilience4j-retry-1.7.0.jar;%APP_HOME%\lib\resilience4j-cache-1.7.0.jar;%APP_HOME%\lib\resilience4j-timelimiter-1.7.0.jar;%APP_HOME%\lib\dashj-bls-0.15.2.20190416.jar;%APP_HOME%\lib\resilience4j-core-1.7.0.jar;%APP_HOME%\lib\slf4j-api-1.7.28.jar;%APP_HOME%\lib\javax.mail-1.6.2.jar;%APP_HOME%\lib\emoji-java-3.1.3.jar;%APP_HOME%\lib\JavaBitcoindRpcClient-860f5d735539ea52838efe3149c98b57f1decd7a.jar;%APP_HOME%\lib\bitrafael-client-api-1.0.44.jar;%APP_HOME%\lib\bitrafael-server-api-1.0.44.jar;%APP_HOME%\lib\javax.ws.rs-api-2.1.jar;%APP_HOME%\lib\javax.servlet-api-3.1.0.jar;%APP_HOME%\lib\jackson-datatype-guava-2.12.0.jar;%APP_HOME%\lib\jackson-datatype-jdk8-2.12.0.jar;%APP_HOME%\lib\jackson-datatype-jsr310-2.12.0.jar;%APP_HOME%\lib\jackson-datatype-cryptoconditions-1.0.4.jar;%APP_HOME%\lib\core-fff6ed0.jar;%APP_HOME%\lib\abi-fff6ed0.jar;%APP_HOME%\lib\utils-fff6ed0.jar;%APP_HOME%\lib\vertx-core-3.5.0.Beta1.jar;%APP_HOME%\lib\jackson-jaxrs-json-provider-2.12.0.jar;%APP_HOME%\lib\jackson-jaxrs-base-2.12.0.jar;%APP_HOME%\lib\jackson-module-jaxb-annotations-2.12.0.jar;%APP_HOME%\lib\jackson-core-2.12.0.jar;%APP_HOME%\lib\jwt-1.0.1.jar;%APP_HOME%\lib\jjwt-jackson-0.10.5.jar;%APP_HOME%\lib\jackson-databind-2.12.0.jar;%APP_HOME%\lib\jackson-annotations-2.12.0.jar;%APP_HOME%\lib\grpc-netty-1.31.0.jar;%APP_HOME%\lib\grpc-okhttp-1.31.0.jar;%APP_HOME%\lib\grpc-protobuf-1.31.0.jar;%APP_HOME%\lib\grpc-stub-1.31.0.jar;%APP_HOME%\lib\protobuf-java-util-3.11.0.jar;%APP_HOME%\lib\grpc-netty-shaded-1.31.0.jar;%APP_HOME%\lib\grpc-core-1.31.0.jar;%APP_HOME%\lib\grpc-protobuf-lite-1.31.0.jar;%APP_HOME%\lib\grpc-api-1.31.0.jar;%APP_HOME%\lib\guava-31.0.1-jre.jar;%APP_HOME%\lib\core-2.3.0.jar;%APP_HOME%\lib\abi-4.9.0.jar;%APP_HOME%\lib\rlp-4.9.0.jar;%APP_HOME%\lib\utils-4.9.0.jar;%APP_HOME%\lib\rxjava-2.2.2.jar;%APP_HOME%\lib\reactive-streams-1.0.2.jar;%APP_HOME%\lib\logging-interceptor-4.9.0.jar;%APP_HOME%\lib\okhttp-4.9.0.jar;%APP_HOME%\lib\okhttp-2.7.4.jar;%APP_HOME%\lib\okio-jvm-2.8.0.jar;%APP_HOME%\lib\bcprov-jdk15on-1.63.jar;%APP_HOME%\lib\protobuf-java-3.13.0.jar;%APP_HOME%\lib\activation-1.1.jar;%APP_HOME%\lib\json-20180130.jar;%APP_HOME%\lib\jakarta.ws.rs-api-2.1.5.jar;%APP_HOME%\lib\perfmark-api-0.19.0.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\signpost-core-1.2.1.2.jar;%APP_HOME%\lib\failureaccess-1.0.1.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\checker-qual-3.12.0.jar;%APP_HOME%\lib\error_prone_annotations-2.7.1.jar;%APP_HOME%\lib\j2objc-annotations-1.3.jar;%APP_HOME%\lib\commons-lang3-3.12.0.jar;%APP_HOME%\lib\javax.annotation-api-1.3.2.jar;%APP_HOME%\lib\lombok-1.18.20.jar;%APP_HOME%\lib\tuples-4.9.0.jar;%APP_HOME%\lib\jnr-unixsocket-0.38.17.jar;%APP_HOME%\lib\kotlin-stdlib-jdk8-1.4.10.jar;%APP_HOME%\lib\kotlin-stdlib-jdk7-1.4.10.jar;%APP_HOME%\lib\kotlin-stdlib-1.4.10.jar;%APP_HOME%\lib\kotlin-stdlib-common-1.4.10.jar;%APP_HOME%\lib\httpclient-4.5.8.jar;%APP_HOME%\lib\commons-codec-1.11.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\commons-io-2.6.jar;%APP_HOME%\lib\jaxb-api-2.3.0.jar;%APP_HOME%\lib\crypto-conditions-1.0.4.jar;%APP_HOME%\lib\bcprov-jdk15to18-1.69.jar;%APP_HOME%\lib\netty-all-4.0.15.Final.jar;%APP_HOME%\lib\core-1.58.0.0.jar;%APP_HOME%\lib\protobuf-javalite-3.18.0.jar;%APP_HOME%\lib\jcip-annotations-1.0.jar;%APP_HOME%\lib\scrypt-1.4.0.jar;%APP_HOME%\lib\vavr-0.10.2.jar;%APP_HOME%\lib\jnr-enxio-0.32.13.jar;%APP_HOME%\lib\jnr-posix-3.1.15.jar;%APP_HOME%\lib\jnr-ffi-2.2.11.jar;%APP_HOME%\lib\jnr-constants-0.10.3.jar;%APP_HOME%\lib\annotations-13.0.jar;%APP_HOME%\lib\httpcore-4.4.11.jar;%APP_HOME%\lib\jjwt-impl-0.10.5.jar;%APP_HOME%\lib\jjwt-api-0.10.5.jar;%APP_HOME%\lib\eddsa-0.3.0.jar;%APP_HOME%\lib\netty-codec-http2-4.1.48.Final.jar;%APP_HOME%\lib\netty-handler-proxy-4.1.48.Final.jar;%APP_HOME%\lib\animal-sniffer-annotations-1.18.jar;%APP_HOME%\lib\proto-google-common-protos-1.17.0.jar;%APP_HOME%\lib\gson-2.8.6.jar;%APP_HOME%\lib\netty-codec-http-4.1.48.Final.jar;%APP_HOME%\lib\netty-handler-4.1.48.Final.jar;%APP_HOME%\lib\netty-resolver-dns-4.1.8.Final.jar;%APP_HOME%\lib\netty-codec-socks-4.1.48.Final.jar;%APP_HOME%\lib\netty-codec-dns-4.1.8.Final.jar;%APP_HOME%\lib\netty-codec-4.1.48.Final.jar;%APP_HOME%\lib\netty-transport-4.1.48.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.48.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.48.Final.jar;%APP_HOME%\lib\netty-common-4.1.48.Final.jar;%APP_HOME%\lib\vavr-match-0.10.2.jar;%APP_HOME%\lib\cache-api-1.1.0.jar;%APP_HOME%\lib\jffi-1.3.9.jar;%APP_HOME%\lib\jffi-1.3.9-native.jar;%APP_HOME%\lib\asm-commons-9.2.jar;%APP_HOME%\lib\asm-util-9.2.jar;%APP_HOME%\lib\asm-analysis-9.2.jar;%APP_HOME%\lib\asm-tree-9.2.jar;%APP_HOME%\lib\asm-9.2.jar;%APP_HOME%\lib\jnr-a64asm-1.0.0.jar;%APP_HOME%\lib\jnr-x86asm-1.0.2.jar;%APP_HOME%\lib\annotations-4.1.1.4.jar;%APP_HOME%\lib\grpc-context-1.31.0.jar;%APP_HOME%\lib\jakarta.xml.bind-api-2.3.2.jar;%APP_HOME%\lib\jakarta.activation-api-1.2.1.jar


@rem Execute server_extensions_test
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %SERVER_EXTENSIONS_TEST_OPTS%  -classpath "%CLASSPATH%" com.generalbytes.batm.server.extensions.test.Tester %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable SERVER_EXTENSIONS_TEST_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%SERVER_EXTENSIONS_TEST_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
