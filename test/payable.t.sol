// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/PayableToken.sol";
import {NFTtoken, ERC165Checker} from "src/NFTtoken.sol";

contract PayableTest is Test {
    NFTtoken public nft;
    PayableToken public payabletoken;

    address contractDeployer = mkaddr("deployer");
    function setUp() public {
        payabletoken = new PayableToken();
        nft = new NFTtoken(address(payabletoken));
    }

    function testTokenMint() public {
        vm.startPrank(contractDeployer);
        payabletoken.freeMint();
        payabletoken.transferAndCall(address(nft), 0.5 ether);
        payabletoken.approveAndCall(address(nft), 0.5 ether);
        vm.stopPrank();
    }


    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    } 
}
