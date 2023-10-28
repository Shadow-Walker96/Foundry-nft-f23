// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {Test, console} from "forge-std/Test.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    /**
     * @dev
     * --->   base64 -i ./images/dynamicNft/example.svg
     *  PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRw
     * Oi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+PHRleHQg
     * eD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj5IaSEgWW91ciBicm93c2VyIGRlY29kZWQgdGhpczwv
     * dGV4dD48L3N2Zz4=
     */

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    /**
     * @dev expectedUri --> base64 encoded result for example.svg
     * svg --> example.svg
     */
    function testConvertSvgToUri() public view {
        string memory expectedUri =
            "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+PHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj5IaSEgWW91ciBicm93c2VyIGRlY29kZWQgdGhpczwvdGV4dD48L3N2Zz4=";
        string memory svg =
            '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500" height="500"><text x="0" y="15" fill="black">Hi! Your browser decoded this</text></svg>';
        string memory actualUri = deployer.svgToImageURI(svg);
        assert(keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedUri)));
    }
}

// forge test --mt testConvertSvgToUri
// [⠢] Compiling...
// [⠒] Compiling 1 files with 0.8.21
// [⠔] Solc 0.8.21 finished in 9.06s
// Compiler run successful!

// Running 1 test for test/DeployMoodNftTest.t.sol:DeployMoodNftTest
// [PASS] testConvertSvgToUri() (gas: 26806)
// Test result: ok. 1 passed; 0 failed; 0 skipped; finished in 3.89ms

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
