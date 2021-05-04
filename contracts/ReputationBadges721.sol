// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./ERC721NonTransferrable.sol";

contract ReputationBadges721 is IERC721, ERC721NonTransferrable {
	using Counters for Counters.Counter;

	event Minted(
		uint256 indexed providerId,
		address indexed to,
		uint256 indexed tokenId
	);

	// Used to track the last token id
	Counters.Counter private _tokenIdTracker;

	// Token name
	string private _name;

	// Token symbol
	string private _symbol;

	// Mapping from token ID to owner address
	mapping(uint256 => address) private _owners;

	// Mapping from owner address to token count
	mapping(address => uint256) private _balances;

	// Mapping from address to provider Id to token id
	mapping(address => mapping(uint256 => uint256))
		private _ownedTokenByProvider;

	// Mapping from tokenId to providerId
	mapping(uint256 => uint256) _providers;

	constructor(string memory name_, string memory symbol_) {
		_name = name_;
		_symbol = symbol_;

		// avoid token with a zero id
		_tokenIdTracker.increment();
	}

	// TEMPORARY, to test
	function mint(address to, uint256 providerId) public {
		uint256 currentId = _tokenIdTracker.current();
		_tokenIdTracker.increment();
		_mint(to, currentId, providerId);
	}

	function getTokenByAddressAndProvider(address owner, uint256 providerId)
		public
		view
		returns (uint256)
	{
		require(owner != address(0), "Query for the zero address");

		return _ownedTokenByProvider[owner][providerId];
	}

	function providerOf(uint256 tokenId) external view returns (uint256) {
		require(_exists(tokenId), "Token does not exist");

		return _providers[tokenId];
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

	function supportsInterface(bytes4 interfaceId)
		public
		pure
		override
		returns (bool)
	{
		return interfaceId == type(IERC721).interfaceId;
	}

	/**
	 * @dev Returns whether `tokenId` exists.
	 *
	 * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
	 *
	 * Tokens start existing when they are minted (`_mint`),
	 * and stop existing when they are burned (`_burn`).
	 */
	function _exists(uint256 tokenId) internal view returns (bool) {
		return _owners[tokenId] != address(0);
	}

	function _mint(
		address to,
		uint256 tokenId,
		uint256 providerId
	) internal {
		require(to != address(0), "ERC721: mint to the zero address");
		require(!_exists(tokenId), "ERC721: token already minted");
		require(
			_ownedTokenByProvider[to][providerId] == 0,
			"Address already has a token for this provider"
		);

		_balances[to] += 1;
		_owners[tokenId] = to;
		_ownedTokenByProvider[to][providerId] = tokenId;
		_providers[tokenId] = providerId;

		emit Transfer(address(0), to, tokenId);
		emit Minted(providerId, to, tokenId);
	}
}
