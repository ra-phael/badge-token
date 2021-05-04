// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract ReputationBadges721 is IERC721 {
	// Token name
	string private _name;

	// Token symbol
	string private _symbol;

	// Mapping from token ID to owner address
	mapping(uint256 => address) private _owners;

	// Mapping owner address to token count
	mapping(address => uint256) private _balances;

	constructor(string memory name_, string memory symbol_) {
		_name = name_;
		_symbol = symbol_;
	}

	modifier NotAllowed {
		revert("Not allowed");
		_;
	}

	/**
	 * @dev Gets the token name
	 * @return string representing the token name
	 */
	function name() external view returns (string memory) {
		return _name;
	}

	/**
	 * @dev Gets the token symbol
	 * @return string representing the token symbol
	 */
	function symbol() external view returns (string memory) {
		return _symbol;
	}

	/**
	 * @dev See {IERC721-balanceOf}.
	 */
	function balanceOf(address owner) public view override returns (uint256) {
		require(
			owner != address(0),
			"ERC721: balance query for the zero address"
		);
		return _balances[owner];
	}

	/**
	 * @dev See {IERC721-ownerOf}.
	 */
	function ownerOf(uint256 tokenId) public view override returns (address) {
		address owner = _owners[tokenId];
		require(
			owner != address(0),
			"ERC721: owner query for nonexistent token"
		);
		return owner;
	}
	
	function supportsInterface(bytes4 interfaceId) public pure override returns (bool) {
        return interfaceId == type(IERC721).interfaceId;
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

	function approve(address to, uint256 tokenId) external override NotAllowed {}

	function getApproved(uint256 tokenId)
		external
		view
		override
		NotAllowed
		returns (address operator) {}

	function setApprovalForAll(address operator, bool _approved)
		external
		override
		NotAllowed {}

	function isApprovedForAll(address owner, address operator)
		external
		view
		override
		NotAllowed
		returns (bool) {}

	function safeTransferFrom(
		address from,
		address to,
		uint256 tokenId,
		bytes calldata data
	) external override NotAllowed {}
}
