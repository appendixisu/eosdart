import 'package:eosdart/eosdart.dart';

main() {
  EOSClient client = EOSClient('https://eos.greymass.com', 'v1');
//  EOSClient client = EOSClient('http://127.0.0.1:8888', 'v1', httpTimeout: 15);

  // Get EOS Node Info
  client.getInfo().then((NodeInfo nodeInfo) {
    print(nodeInfo);
  });

  // Get EOS Abi
  client.getAbi(accountName: 'eosio.token').then((AbiResp abi) {
    print(abi);
  });

  // Get EOS Raw Abi
  client.getRawAbi(accountName: 'eosio.token').then((AbiResp abi) {
    print(abi);
  });

  // Get EOS Raw code and Abi
  client.getRawCodeAndAbi(accountName: 'eosio.token').then((AbiResp abi) {
    print(abi);
  });

  // Get EOS Block Info
  client.getBlock(blockNumOrId: '298674').then((Block block) {
    print(block);
  });

  // Get Account Info
  client.getAccount(accountName: 'eosio.token').then((Account account) {
    print(account);
  });

  // Get Account Actions
  client
      .getActions(accountName: 'eosio.token', pos: -1, offset: -1)
      .then((Actions actions) {
    print(actions);
  });

  // Get Transaction
  client
      .getTransaction(
          id: '83875faeb054ba20b20f392418e3a0002c4bb1c36cc4e3fde15cbd0963da8a15',
          blockNumHint: null)
      .then((TransactionBlock transaction) {
    print(transaction);
  });

  // Get Accounts from public key
  client
      .getKeyAccounts(
          pubKey: 'EOS8RWQpzzMi5uFXXXAChi4dHnyxMYKKdAQ3Y3pHQTrvhzGk95LbT')
      .then((AccountNames accountNames) {
    print(accountNames);
  });

  // Get currency balance
  client
      .getCurrencyBalance(code: 'parslseed123', account: 'newdexpocket')
      .then((List<Holding> balance) {
    print(balance);
  });

  // Get Tables
  client.getTableRows('eosio', 'eosio', 'abihash').then((rows) => print(rows));
  client.getTableRow('eosio', 'eosio', 'abihash').then((row) => print(row));
}
