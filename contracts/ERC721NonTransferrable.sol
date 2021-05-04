// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

abstract contract ERC721NonTransferrable is IERC721 {
	modifier NotAllowed {
		revert("Not allowed");
		_;
	}

	function safeTransferFrom(
		address from,
		address to,
		uint256 tokenId
	) external override NotAllowed {}

	function transferFrom(
		address from,
		address to,
		uint256 tokenId
	) external override NotAllowed {}

	function approve(address to, uint256 tokenId)
		external
		override
		NotAllowed
	{}

	function getApproved(uint256 tokenId)
		external
		view
		override
		NotAllowed
		returns (address operator)
	{}

	function setApprovalForAll(address operator, bool _approved)
		external
		override
		NotAllowed
	{}

	function isApprovedForAll(address owner, address operator)
		external
		view
		override
		NotAllowed
		returns (bool)
	{}

	function safeTransferFrom(
		address from,
		address to,
		uint256 tokenId,
		bytes calldata data
	) external override NotAllowed {}
}
