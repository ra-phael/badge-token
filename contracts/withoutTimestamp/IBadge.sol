// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBadge {
	// @dev Emitted when `tokenId` token is minted to `to`, an address.
	event Minted(
		address indexed to,
		bytes32 indexed tokenId,
		uint256 timestamp
	);

	// @dev Emitted when `tokenId` token is burned.
	event Burned(
		address indexed owner,
		bytes32 indexed tokenId,
		uint256 timestamp
	);

	// @dev Returns the badge's name
	function name() external view returns (string memory);

	// @dev Returns the badge's symbol.
	function symbol() external view returns (string memory);

	// @dev Returns the ID of the token owned by `owner`, if it owns one, and 0 otherwise
	function tokenOf(address owner) external view returns (bytes32);

	// @dev Returns the owner of the `tokenId` token.
	function ownerOf(bytes32 tokenId) external view returns (address);
}
