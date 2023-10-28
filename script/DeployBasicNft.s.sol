// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {console} from "forge-std/console.sol";

contract DeployBasicNft is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (BasicNft) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }
        vm.startBroadcast(deployerKey);
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    }
}

// make deploy ARGS="--network sepolia"
// [⠆] Compiling...
// No files changed, compilation skipped
// Traces:
//   [949535] DeployBasicNft::run()
//     ├─ [0] VM::envUint(PRIVATE_KEY) [staticcall]
//     │   └─ ← <env var value>
//     ├─ [0] VM::startBroadcast(<pk>)
//     │   └─ ← ()
//     ├─ [869406] → new BasicNft@0xad1497A4dd7146A9390FF8a57cC751302470D900
//     │   └─ ← 4106 bytes of code
//     ├─ [0] VM::stopBroadcast()
//     │   └─ ← ()
//     └─ ← BasicNft: [0xad1497A4dd7146A9390FF8a57cC751302470D900]

// Script ran successfully.

// == Return ==
// 0: contract BasicNft 0xad1497A4dd7146A9390FF8a57cC751302470D900

// ## Setting up (1) EVMs.
// ==========================
// Simulated On-chain Traces:

//   [994330] → new BasicNft@0xad1497A4dd7146A9390FF8a57cC751302470D900
//     └─ ← 4106 bytes of code

// ==========================

// Chain 11155111

// Estimated gas price: 3.00000004 gwei

// Estimated total gas used for script: 1292629

// Estimated amount required: 0.00387788705170516 ETH

// ==========================

// ###
// Finding wallets for all the necessary addresses...
// ##
// Sending transactions [0 - 0].
// ⠁ [00:00:00] [#########################################################################################] 1/1 txes (0.0s)
// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/broadcast/DeployBasicNft.s.sol/11155111/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/cache/DeployBasicNft.s.sol/11155111/run-latest.json

// ##
// Waiting for receipts.
// ⠉ [00:00:13] [#####################################################################################] 1/1 receipts (0.0s)
// ##### sepolia
// ✅  [Success]Hash: 0x975afee5f57657f0a23ee32a6d4e4442978c63cb12e641d7db5e0a749c2f1540
// Contract Address: 0xad1497A4dd7146A9390FF8a57cC751302470D900
// Block: 4577628
// Paid: 0.00298386001690854 ETH (994620 gas * 3.000000017 gwei)

// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/broadcast/DeployBasicNft.s.sol/11155111/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/cache/DeployBasicNft.s.sol/11155111/run-latest.json

// ==========================

// ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
// Total Paid: 0.00298386001690854 ETH (994620 gas * avg 3.000000017 gwei)
// ##
// Start verification for (1) contracts
// Start verifying contract `0xad1497A4dd7146A9390FF8a57cC751302470D900` deployed on sepolia

// Submitting verification for [src/BasicNft.sol:BasicNft] "0xad1497A4dd7146A9390FF8a57cC751302470D900".

// Submitting verification for [src/BasicNft.sol:BasicNft] "0xad1497A4dd7146A9390FF8a57cC751302470D900".
// Submitted contract for verification:
//         Response: `OK`
//         GUID: `myjpyfqfqr6gv3uvckv8yvfmrdq77q1d76y3irmb3riiy4sder`
//         URL:
//         https://sepolia.etherscan.io/address/0xad1497a4dd7146a9390ff8a57cc751302470d900
// Contract verification status:
// Response: `NOTOK`
// Details: `Pending in queue`
// Contract verification status:
// Response: `OK`
// Details: `Pass - Verified`
// Contract successfully verified
// All (1) contracts were verified!

// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/broadcast/DeployBasicNft.s.sol/11155111/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/cache/DeployBasicNft.s.sol/11155111/run-latest.json
