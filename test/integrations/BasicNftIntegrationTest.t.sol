// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {MintBasicNft} from "../../script/Interactions.s.sol";

contract BasicNftIntegrationTest is Test {
    string constant NFT_NAME = "Dogie";
    string constant NFT_SYMBOL = "DOG";

    BasicNft public basicNft;
    DeployBasicNft public deployer;

    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    address public USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrrct() public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assertEq(actualName, expectedName);
    }

    /**
     * @dev assert(actualName == expectedName); ---> will display an error below
     * Built-in binary operator == cannot be applied to types string memory and string memory.
     * Remember that strings are array of bytes, so we cant compare array to an array
     *
     * But we can compare the hashes of the strings using an hash function
     *
     * In solidity, strings are more complex types(they are essentially dynamic arrays), and therefore
     * cant be compared directly with '=='.
     * However, you can compare their kaccak256 hashes, which are fixed length and can be compared
     * directly.
     */
    function testNameIsCorrrct1() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // assert(actualName == expectedName); i explained above why this will fail

        // keccak256 is a hash function that takes in a string and returns a bytes32
        // abi.encodePacked is a solidity function that takes in a string and returns a bytes
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG_URI)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }

    function testInitializedCorrectly() public view {
        assert(keccak256(abi.encodePacked(basicNft.name())) == keccak256(abi.encodePacked((NFT_NAME))));
        assert(keccak256(abi.encodePacked(basicNft.symbol())) == keccak256(abi.encodePacked((NFT_SYMBOL))));
    }

    function testMintWithScript() public {
        uint256 startingTokenCount = basicNft.getTokenCounter();
        MintBasicNft mintBasicNft = new MintBasicNft();
        mintBasicNft.mintNftOnContract(address(basicNft));
        assert(basicNft.getTokenCounter() == startingTokenCount + 1);
    }
}

// forge test
// [⠒] Compiling...
// [⠘] Compiling 1 files with 0.8.21
// [⠊] Solc 0.8.21 finished in 7.69s
// Compiler run successful!

// Running 4 tests for test/BasicNftTest.t.sol:BasicNftTest
// [PASS] testCanMintAndHaveABalance() (gas: 175208)
// [PASS] testInitializedCorrectly() (gas: 14593)
// [PASS] testNameIsCorrrct() (gas: 9631)
// [PASS] testNameIsCorrrct1() (gas: 9598)
// Test result: ok. 4 passed; 0 failed; 0 skipped; finished in 4.98ms

// Ran 1 test suites: 4 tests passed, 0 failed, 0 skipped (4 total tests)

// forge test --mt testMintWithScript
// [⠑] Compiling...
// [⠘] Compiling 3 files with 0.8.21
// [⠒] Solc 0.8.21 finished in 15.21s
// Compiler run successful!

// Running 1 test for test/BasicNftTest.t.sol:BasicNftTest
// [PASS] testMintWithScript() (gas: 431158)
// Test result: ok. 1 passed; 0 failed; 0 skipped; finished in 10.75ms

// Ran 1 test suites: 1 tests passed, 0 failed, 0 skipped (1 total tests)


// forge test
// [⠊] Compiling...
// [⠘] Compiling 1 files with 0.8.21
// [⠊] Solc 0.8.21 finished in 7.70s
// Compiler run successful!

// Running 5 tests for test/integrations/BasicNftIntegrationTest.t.sol:BasicNftIntegrationTest
// [PASS] testCanMintAndHaveABalance() (gas: 175208)
// [PASS] testInitializedCorrectly() (gas: 14593)
// [PASS] testMintWithScript() (gas: 431158)
// [PASS] testNameIsCorrrct() (gas: 9631)
// [PASS] testNameIsCorrrct1() (gas: 9598)
// Test result: ok. 5 passed; 0 failed; 0 skipped; finished in 5.24ms

// Running 2 tests for test/integrations/MoodNftIntegrationTest.t.sol:MoodNftIntegrationTest
// [PASS] testFlipTokenToSad() (gas: 408349)
// [PASS] testViewTokenURIIntegration() (gas: 197072)
// Test result: ok. 2 passed; 0 failed; 0 skipped; finished in 12.65ms

// Running 1 test for test/unit/DeployMoodNftTest.t.sol:DeployMoodNftTest
// [PASS] testConvertSvgToUri() (gas: 26806)
// Test result: ok. 1 passed; 0 failed; 0 skipped; finished in 2.18ms

// Running 1 test for test/unit/MoodNftTest.sol:MoodNftTest
// [PASS] testViewTokenURI() (gas: 460780)
// Test result: ok. 1 passed; 0 failed; 0 skipped; finished in 8.03ms

// Ran 4 test suites: 9 tests passed, 0 failed, 0 skipped (9 total tests)


// source .env
// shadow-walker@DESKTOP-E7205AL:~/foundry-full-course-f23/foundry-nft-f23$ forge test --fork-url $SEPOLIA_RPC_URL
// [⠒] Compiling...
// [⠰] Compiling 4 files with 0.8.21
// [⠒] Solc 0.8.21 finished in 13.28s
// Compiler run successful!

// Running 5 tests for test/integrations/BasicNftIntegrationTest.t.sol:BasicNftIntegrationTest
// [PASS] testCanMintAndHaveABalance() (gas: 175208)
// [PASS] testInitializedCorrectly() (gas: 14593)
// [PASS] testMintWithScript() (gas: 431158)
// [PASS] testNameIsCorrrct() (gas: 9631)
// [PASS] testNameIsCorrrct1() (gas: 9598)
// Test result: ok. 5 passed; 0 failed; 0 skipped; finished in 3.76s

// Running 1 test for test/unit/DeployMoodNftTest.t.sol:DeployMoodNftTest
// [PASS] testConvertSvgToUri() (gas: 26806)
// Test result: ok. 1 passed; 0 failed; 0 skipped; finished in 11.00ms

// Running 2 tests for test/integrations/MoodNftIntegrationTest.t.sol:MoodNftIntegrationTest
// [PASS] testFlipTokenToSad() (gas: 408349)
// [PASS] testViewTokenURIIntegration() (gas: 197072)
// Test result: ok. 2 passed; 0 failed; 0 skipped; finished in 4.02s

// Running 1 test for test/unit/MoodNftTest.sol:MoodNftTest
// [PASS] testViewTokenURI() (gas: 460780)
// Test result: ok. 1 passed; 0 failed; 0 skipped; finished in 192.99ms

// Ran 4 test suites: 9 tests passed, 0 failed, 0 skipped (9 total tests)
