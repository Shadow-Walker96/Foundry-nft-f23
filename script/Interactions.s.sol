// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintBasicNft is Script {
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    uint256 deployerKey;

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address basicNftAddress) public {
        vm.startBroadcast();
        BasicNft(basicNftAddress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedBasicNft);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}



// make deployMood
// [⠊] Compiling...
// [⠢] Compiling 7 files with 0.8.21
// [⠔] Solc 0.8.21 finished in 18.21s
// Compiler run successful!
// Script ran successfully.

// == Return ==
// 0: contract MoodNft 0x5FbDB2315678afecb367f032d93F642f64180aa3

// EIP-3855 is not supported in one or more of the RPCs used.
// Unsupported Chain IDs: 31337.
// Contracts deployed with a Solidity version equal or higher than 0.8.20 might not work properly.
// For more information, please see https://eips.ethereum.org/EIPS/eip-3855

// ## Setting up (1) EVMs.

// ==========================

// Chain 31337

// Estimated gas price: 3.000388644 gwei

// Estimated total gas used for script: 3514633

// Estimated amount required: 0.010545264941027652 ETH

// ==========================

// ###
// Finding wallets for all the necessary addresses...
// ##
// Sending transactions [0 - 0].
// ⠁ [00:00:00] [#########################################################################################] 1/1 txes (0.0s)
// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/broadcast/DeployMoodNft.s.sol/31337/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/cache/DeployMoodNft.s.sol/31337/run-latest.json

// ##
// Waiting for receipts.
// ⠉ [00:00:02] [#####################################################################################] 1/1 receipts (0.0s)
// ##### anvil-hardhat
// ✅  [Success]Hash: 0xfd63bfaecdb9a309b24ae98998a1229e9f544558e4722cc80e11eace4f90cbb4
// Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
// Block: 67
// Paid: 0.008112606305828904 ETH (2704068 gas * 3.000148778 gwei)


// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/broadcast/DeployMoodNft.s.sol/31337/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/cache/DeployMoodNft.s.sol/31337/run-latest.json



// ==========================

// ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
// Total Paid: 0.008112606305828904 ETH (2704068 gas * avg 3.000148778 gwei)

// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/broadcast/DeployMoodNft.s.sol/31337/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-nft-f23/cache/DeployMoodNft.s.sol/31337/run-latest.json



