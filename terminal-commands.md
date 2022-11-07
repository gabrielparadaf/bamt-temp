## clean

./gradlew clean

## buil

./gradlew build

## install tester
./gradlew :server_extensions_test:install

## run tester

./server_extensions_test/build/install/server_extensions_test/bin/server_extensions_test

## run tester w/ an action and the .jar file
./server_extensions_test/build/install/server_extensions_test/bin/server_extensions_test -a list-wallets -j ./server_extensions_extra/build/libs/batm_server_extensions_extra.jar

## get wallet balance
./server_extensions_test/build/install/server_extensions_test/bin/server_extensions_test -n polygonERC20_MATICOIN_18_0x7ee71692e3B19064b9C594DD7e5689A6076450d8 -a get-wbalance -p 564fcb61407b4dc3ac15650a05d9058c:ceiling any spatial green panic model egg poem rather toe cart soon  -j ./server_extensions_extra/build/libs/batm_server_extensions_extra.jar

## get wallet balance (change -n)
./server_extensions_test/build/install/server_extensions_test/bin/server_extensions_test -n infuraERC20_DAI_18_0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359 -a get-wbalance -p 564fcb61407b4dc3ac15650a05d9058c:ceiling any spatial green panic model egg poem rather toe cart soon  -j ./server_extensions_extra/build/libs/batm_server_extensions_extra.jar