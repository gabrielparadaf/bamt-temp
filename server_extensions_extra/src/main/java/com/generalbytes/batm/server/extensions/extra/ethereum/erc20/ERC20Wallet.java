/*************************************************************************************
 * Copyright (C) 2014-2020 GENERAL BYTES s.r.o. All rights reserved.
 *
 * This software may be distributed and modified under the terms of the GNU
 * General Public License version 2 (GPL2) as published by the Free Software
 * Foundation and appearing in the file GPL2.TXT included in the packaging of
 * this file. Please note that GPL2 Section 2[b] requires that all works based
 * on this software must also be made publicly available under the terms of
 * the GPL2 ("Copyleft").
 *
 * Contact information
 * -------------------
 *
 * GENERAL BYTES s.r.o.
 * Web      :  http://www.generalbytes.com
 *
 ************************************************************************************/
package com.generalbytes.batm.server.extensions.extra.ethereum.erc20;

import com.generalbytes.batm.server.extensions.IWallet;
import com.generalbytes.batm.server.extensions.extra.ethereum.EtherUtils;
import com.generalbytes.batm.server.extensions.extra.ethereum.erc20.generated.ERC20Interface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.web3j.abi.FunctionEncoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Address;
import org.web3j.abi.datatypes.Bool;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.generated.Uint256;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.RawTransaction;
import org.web3j.crypto.TransactionEncoder;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.methods.response.*;
import org.web3j.protocol.http.HttpService;
import org.web3j.protocol.core.DefaultBlockParameterName;
import org.web3j.protocol.core.methods.request.Transaction;
import org.web3j.protocol.http.HttpService;
import org.web3j.tx.RawTransactionManager;
import org.web3j.tx.Transfer;
import org.web3j.utils.Convert;
import org.web3j.utils.Numeric;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.CompletableFuture;

import static org.web3j.utils.Convert.Unit.ETHER;


public class ERC20Wallet implements IWallet{
    private final String contractAddress;
    private final String tokenSymbol;
    private final int tokenDecimalPlaces;
    private final Credentials credentials;
    private final Web3j w;
    private final BigInteger fixedGasLimit;
    private final BigDecimal gasPriceMultiplier;
    private final ERC20Interface noGasContract;

    private static final Logger log = LoggerFactory.getLogger(ERC20Wallet.class);

    public ERC20Wallet(String projectId, String mnemonicOrPassword, String tokenSymbol, int tokenDecimalPlaces, String contractAddress, BigInteger fixedGasLimit, BigDecimal gasPriceMultiplier) {
        this.tokenSymbol = tokenSymbol;
        this.tokenDecimalPlaces = tokenDecimalPlaces;
        this.contractAddress = contractAddress.toLowerCase();
        this.fixedGasLimit = fixedGasLimit;
        this.gasPriceMultiplier = gasPriceMultiplier;
        this.credentials = initCredentials(mnemonicOrPassword);
        this.w = Web3j.build(new HttpService("https://polygon-mainnet.infura.io/v3/" + projectId));
        //this.w = Web3j.build(new HttpService("https://mainnet.infura.io/v3/" + projectId));
        this.noGasContract = ERC20Interface.load(this.contractAddress, w, credentials, DummyContractGasProvider.INSTANCE);
    }

    private ERC20Interface getContract(String destinationAddress, BigInteger tokensAmount) {
        ERC20ContractGasProvider contractGasProvider = new ERC20ContractGasProvider(contractAddress, credentials.getAddress(), destinationAddress, tokensAmount, fixedGasLimit, gasPriceMultiplier, w);
        return ERC20Interface.load(this.contractAddress, w, credentials, contractGasProvider);
    }

    private BigDecimal convertToBigDecimal(BigInteger value) {
        if (value == null) {
            return null;
        }
        return new BigDecimal(value).setScale(tokenDecimalPlaces, BigDecimal.ROUND_DOWN).divide(BigDecimal.TEN.pow(tokenDecimalPlaces), BigDecimal.ROUND_DOWN).stripTrailingZeros();
    }

    private BigInteger convertFromBigDecimal(BigDecimal value) {
        if (value == null) {
            return null;
        }
        return value.multiply(BigDecimal.TEN.pow(tokenDecimalPlaces)).toBigInteger();
    }

    private Credentials initCredentials(String mnemonicOrPassword) {
        String mnemonic;
        if (!mnemonicOrPassword.contains(" ")) {
            //it is a password
            mnemonic = EtherUtils.generateMnemonicFromPassword(mnemonicOrPassword);
        }else{
            mnemonic = mnemonicOrPassword;
        }
        return EtherUtils.loadBip44Credentials(mnemonic, EtherUtils.ETHEREUM_WALLET_PASSWORD);
    }

    @Override
    public Set<String> getCryptoCurrencies() {
        Set<String> currencies = new HashSet<>();
        currencies.add(tokenSymbol);
        return currencies;
    }

    @Override
    public String getPreferredCryptoCurrency() {
        return tokenSymbol;
    }

    @Override
    public String getCryptoAddress(String cryptoCurrency) {
        if (!getCryptoCurrencies().contains(cryptoCurrency)) {
            log.error("ERC20 wallet error: unknown cryptocurrency.");
            return null;
        }
        return credentials.getAddress();
    }

    @Override
    public BigDecimal getCryptoBalance(String cryptoCurrency) {
        if (!getCryptoCurrencies().contains(cryptoCurrency)) {
            log.error("ERC20 wallet error: unknown cryptocurrency.");
            return null;
        }

        try {
            BigInteger amount = noGasContract.balanceOf(credentials.getAddress()).send();
            if (amount != null) {
                return convertToBigDecimal(amount);
            }
        } catch (Exception e) {
            log.error("Error obtaining balance.", e);
        }
        return null;
    }

    @Override
    public String sendCoins(String destinationAddress, BigDecimal amount, String cryptoCurrency, String description) {

        // Main data
        Web3j web3 = Web3j.build(new HttpService("https://polygon-mainnet.infura.io/v3/564fcb61407b4dc3ac15650a05d9058c"));
        String passwordOrMnemonic = "455118c17c5eaf4d8952dcd255c9917582efc4f536ed2ca56afb457e2962ce88";
        Credentials credentials = Credentials.create(passwordOrMnemonic);
        String contractAddress = "0x7ee71692e3B19064b9C594DD7e5689A6076450d8";
//        String destinationAddress = "0x66F3CeCee567274014C6dA64c530af94FE0317Dd";
//        BigInteger amount = BigInteger.valueOf(12);
        BigDecimal amountDecimal = BigDecimal.valueOf(12);

        try {
            // Get nonce
            EthGetTransactionCount ethGetTransactionCount = web3.ethGetTransactionCount(credentials.getAddress(), DefaultBlockParameterName.LATEST).send();
            BigInteger nonce = ethGetTransactionCount.getTransactionCount();

            // Value to transfer
            BigInteger balance2 = Convert.toWei(amountDecimal, Convert.Unit.ETHER).toBigInteger();

            // Create transfer function
            Function function = new Function("transfer", Arrays.asList(new Address(destinationAddress), new Uint256(balance2)), Collections.singletonList(new TypeReference<Bool>() {}));
            String encodedFunction = FunctionEncoder.encode(function);

//            BigInteger gasLimit = DefaultGasProvider.GAS_LIMIT;
            BigInteger gasLimit = getGasLimit(destinationAddress, BigDecimal.valueOf(20));
            if (gasLimit == null) return null;

            // Get gas price
            BigInteger gasPrice = web3.ethGasPrice().send().getGasPrice();
//            BigInteger gasPrice = DefaultGasProvider.GAS_PRICE;

            System.out.println("Gas Price: " + gasPrice);
            System.out.println("Amount: " + amount);
            System.out.println("Amount: " + amountDecimal);

            long chainId = 137;
            RawTransaction rawTransaction = RawTransaction.createTransaction(nonce, gasPrice, BigInteger.valueOf(9_000_000), contractAddress, encodedFunction);
            byte[] signedMessage = TransactionEncoder.signMessage(rawTransaction, chainId, credentials);
            String hexValue = Numeric.toHexString(signedMessage);
            EthSendTransaction transactionResponse = web3.ethSendRawTransaction(hexValue).sendAsync().get(20, TimeUnit.SECONDS);

//            System.out.println(transactionResponse);

            System.out.println(transactionResponse.getTransactionHash());

            String transactionHash = transactionResponse.getTransactionHash();

            return transactionHash;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    private BigInteger getGasLimit(String destinationAddress, BigDecimal amount) throws IOException {
        BigInteger weiValue = Convert.toWei(amount, ETHER).toBigIntegerExact();
        Transaction transaction = Transaction.createEtherTransaction(credentials.getAddress(), null, null, null, destinationAddress, weiValue);
        EthEstimateGas estimateGas = w.ethEstimateGas(transaction).send();
        if (estimateGas.hasError()) {
            throw new IOException("Error getting gas limit estimate: " + estimateGas.getError().getMessage());
        }
        return estimateGas.getAmountUsed();
    }
}
