// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {MoodNft} from "../../src/MoodNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";

contract MoodNftTest is Test {
    MoodNft moodNft;

    address USER = makeAddr("user");

    string public constant HAPPY_MOOD_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIyYVdWM1FtOTRQU0l3SURBZ01qQXdJREl3TUNJZ2QybGtkR2c5SWpRd01DSWdJR2hsYVdkb2REMGlOREF3SWlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpUGdvZ0lEeGphWEpqYkdVZ1kzZzlJakV3TUNJZ1kzazlJakV3TUNJZ1ptbHNiRDBpZVdWc2JHOTNJaUJ5UFNJM09DSWdjM1J5YjJ0bFBTSmliR0ZqYXlJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWk4K0NpQWdQR2NnWTJ4aGMzTTlJbVY1WlhNaVBnb2dJQ0FnUEdOcGNtTnNaU0JqZUQwaU5qRWlJR041UFNJNE1pSWdjajBpTVRJaUx6NEtJQ0FnSUR4amFYSmpiR1VnWTNnOUlqRXlOeUlnWTNrOUlqZ3lJaUJ5UFNJeE1pSXZQZ29nSUR3dlp6NEtJQ0E4Y0dGMGFDQmtQU0p0TVRNMkxqZ3hJREV4Tmk0MU0yTXVOamtnTWpZdU1UY3ROalF1TVRFZ05ESXRPREV1TlRJdExqY3pJaUJ6ZEhsc1pUMGlabWxzYkRwdWIyNWxPeUJ6ZEhKdmEyVTZJR0pzWVdOck95QnpkSEp2YTJVdGQybGtkR2c2SURNN0lpOCtDand2YzNablBnPT0ifQ==";

    string public constant SAD_MOOD_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBEOTRiV3dnZG1WeWMybHZiajBpTVM0d0lpQnpkR0Z1WkdGc2IyNWxQU0p1YnlJL1BnbzhjM1puSUhkcFpIUm9QU0l4TURJMGNIZ2lJR2hsYVdkb2REMGlNVEF5TkhCNElpQjJhV1YzUW05NFBTSXdJREFnTVRBeU5DQXhNREkwSWlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpUGdvZ0lEeHdZWFJvSUdacGJHdzlJaU16TXpNaUlHUTlJazAxTVRJZ05qUkRNalkwTGpZZ05qUWdOalFnTWpZMExqWWdOalFnTlRFeWN6SXdNQzQySURRME9DQTBORGdnTkRRNElEUTBPQzB5TURBdU5pQTBORGd0TkRRNFV6YzFPUzQwSURZMElEVXhNaUEyTkhwdE1DQTRNakJqTFRJd05TNDBJREF0TXpjeUxURTJOaTQyTFRNM01pMHpOekp6TVRZMkxqWXRNemN5SURNM01pMHpOeklnTXpjeUlERTJOaTQySURNM01pQXpOekl0TVRZMkxqWWdNemN5TFRNM01pQXpOeko2SWk4K0NpQWdQSEJoZEdnZ1ptbHNiRDBpSTBVMlJUWkZOaUlnWkQwaVRUVXhNaUF4TkRCakxUSXdOUzQwSURBdE16Y3lJREUyTmk0MkxUTTNNaUF6TnpKek1UWTJMallnTXpjeUlETTNNaUF6TnpJZ016Y3lMVEUyTmk0MklETTNNaTB6TnpJdE1UWTJMall0TXpjeUxUTTNNaTB6TnpKNlRUSTRPQ0EwTWpGaE5EZ3VNREVnTkRndU1ERWdNQ0F3SURFZ09UWWdNQ0EwT0M0d01TQTBPQzR3TVNBd0lEQWdNUzA1TmlBd2VtMHpOellnTWpjeWFDMDBPQzR4WXkwMExqSWdNQzAzTGpndE15NHlMVGd1TVMwM0xqUkROakEwSURZek5pNHhJRFUyTWk0MUlEVTVOeUExTVRJZ05UazNjeTA1TWk0eElETTVMakV0T1RVdU9DQTRPQzQyWXkwdU15QTBMakl0TXk0NUlEY3VOQzA0TGpFZ055NDBTRE0yTUdFNElEZ2dNQ0F3SURFdE9DMDRMalJqTkM0MExUZzBMak1nTnpRdU5TMHhOVEV1TmlBeE5qQXRNVFV4TGpaek1UVTFMallnTmpjdU15QXhOakFnTVRVeExqWmhPQ0E0SURBZ01DQXhMVGdnT0M0MGVtMHlOQzB5TWpSaE5EZ3VNREVnTkRndU1ERWdNQ0F3SURFZ01DMDVOaUEwT0M0d01TQTBPQzR3TVNBd0lEQWdNU0F3SURrMmVpSXZQZ29nSUR4d1lYUm9JR1pwYkd3OUlpTXpNek1pSUdROUlrMHlPRGdnTkRJeFlUUTRJRFE0SURBZ01TQXdJRGsySURBZ05EZ2dORGdnTUNBeElEQXRPVFlnTUhwdE1qSTBJREV4TW1NdE9EVXVOU0F3TFRFMU5TNDJJRFkzTGpNdE1UWXdJREUxTVM0MllUZ2dPQ0F3SURBZ01DQTRJRGd1TkdnME9DNHhZelF1TWlBd0lEY3VPQzB6TGpJZ09DNHhMVGN1TkNBekxqY3RORGt1TlNBME5TNHpMVGc0TGpZZ09UVXVPQzA0T0M0MmN6a3lJRE01TGpFZ09UVXVPQ0E0T0M0Mll5NHpJRFF1TWlBekxqa2dOeTQwSURndU1TQTNMalJJTmpZMFlUZ2dPQ0F3SURBZ01DQTRMVGd1TkVNMk5qY3VOaUEyTURBdU15QTFPVGN1TlNBMU16TWdOVEV5SURVek0zcHRNVEk0TFRFeE1tRTBPQ0EwT0NBd0lERWdNQ0E1TmlBd0lEUTRJRFE0SURBZ01TQXdMVGsySURCNklpOCtDand2YzNablBnbz0ifQ==";

    function setUp() public {
        moodNft = new MoodNft(HAPPY_MOOD_URI, SAD_MOOD_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }
}


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
