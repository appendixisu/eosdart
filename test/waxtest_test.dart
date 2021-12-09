import 'package:eosdart/eosdart.dart';
import 'package:test/test.dart';

void main() {
  group('EOS Client', () {
    EOSClient client = EOSClient('https://testnet.waxsweden.org', 'v1');

    test('Get Info', () async {
      NodeInfo nodeInfo = await client.getInfo();
      print(nodeInfo.toJson());
      expect(((nodeInfo.headBlockNum ?? 0) > 0), isTrue);
    });

    test('Get Abi', () async {
      AbiResp abi = await client.getAbi(accountName: 'eosio.token');
      expect(abi.accountName, equals('eosio.token'));
    });

    test('Get Raw Abi', () async {
      AbiResp abi = await client.getRawAbi(accountName: 'eosio.token');
      expect(abi.accountName, equals('eosio.token'));
      expect(abi.codeHash,
          'f6a2939074d69fc194d4b7b5a4d2c24e2766046ddeaa58b63ddfd579a0193623');
      expect(abi.abiHash,
          '85fd4e647e88e595223e69d09a3368a14a45d29320ed1515f54fdfac6ca999df');
      expect(abi.abi, isNotNull);
    });

    test('Get Raw code and Abi', () async {
      AbiResp abi = await client.getRawCodeAndAbi(accountName: 'eosio.token');
      expect(abi.accountName, equals('eosio.token'));
      expect((abi.wasm?.length ?? 0) > 0, isTrue);
      expect(abi.abi, isNotNull);
    });

    test('Get Block', () async {
      Block block = await client.getBlock(blockNumOrId: '43743575');
      expect((block.blockNum ?? 0) > 0, isTrue);
      expect(block.producer, 'zbeosbp11111');
      expect(block.confirmed, 0);
      expect(block.transactionMRoot,
          '8fb685526d58dfabd05989b45b8576197acc1be59d753bb396386d5d718f9fa9');
      expect((block.transactions?.length ?? 0) > 10, isTrue);
    });

    test('Get Account', () async {
      Account account = await client.getAccount(accountName: 'eosio.stake');
      expect(account.accountName, equals('eosio.stake'));
      expect((account.coreLiquidBalance?.amount ?? 0) > 0, isTrue);
    });

    test('Get currency balance', () async {
      List<Holding> tokens = await client.getCurrencyBalance(
        code: 'parslseed123',
        account: 'newdexpocket',
        symbol: 'SEED',
      );

      expect(tokens.length > 0, isTrue);
      expect((tokens[0].amount ?? 0) > 0, isTrue);
      expect(tokens[0].currency, 'SEED');
    });

    test('Get Transaction', () async {
      TransactionBlock transaction = await client.getTransaction(
          id: '8ca0fea82370a2dbbf2c4bd1026bf9fd98a57685bee3672c4ddbbc9be21de984');
      expect(transaction.blockNum, 43743575);
      expect(transaction.trx?.receipt?.cpuUsageUs, 132);
      expect(transaction.trx?.receipt?.netUsageWords, 0);
      expect(transaction.traces?.length, 2);
      expect(transaction.traces?[0].receipt?.receiver, 'trustdicelog');
      // expect(transaction.traces?[0].inlineTraces?.length, 1);
      // expect(transaction.traces?[0].inlineTraces?[0].receipt?.receiver,
      // 'ge4tcnrxgyge');
    });
  });
}
