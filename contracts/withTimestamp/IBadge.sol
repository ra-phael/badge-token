// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBadge {
	struct Token {
		bytes32 id;
		uint256 timestamp;
	}

	/**
	 * @dev Emitted when a token is minted to `to` with an id of `tokenId`.
	 * @param to The address that received the token
	 * @param tokenId The id of the token that was minted
	 * @param timestamp Block timestamp from when the token was minted
	 */
	event Minted(
		address indexed to,
		bytes32 indexed tokenId,
		uint256 timestamp
	);

	/**
	 * @dev Emitted when a token is updated with a new timestamp.
	 * @param owner The address that owns the token
	 * @param tokenId The id of the token
	 * @param timestamp Block timestamp from when the token was "re-issued"
	 */
	event Updated(
		address indexed owner,
		bytes32 indexed tokenId,
		uint256 timestamp
	);

	/**
	 * @dev Emitted when a token is burned.
	 * @param owner The address that used to own the token
	 * @param tokenId The id of the token that was burned
	 * @param timestamp Block timestamp from when the token was burned
	 */
	event Burned(
		address indexed owner,
		bytes32 indexed tokenId,
		uint256 timestamp
	);

	/**
	 * @dev Returns the badge's name.
	 */
	function name() external view returns (string memory);

	/**
	 * @dev Returns the badge's symbol.
	 */
	function symbol() external view returns (string memory);

	/**
	 * @dev Returns the token owned by `owner`, if they own one, and an empty Token otherwise
	 *
	 * Requirements:
	 *
	 * - `owner` cannot be the zero address.
	 */
	function tokenOf(address owner) external view returns (Token memory);

	/**
	 * @dev Returns the owner of the token with given `tokenId`.
	 *
	 * Requirements:
	 *
	 * - A token with `tokenId` must exist.
	 */
	function ownerOf(bytes32 tokenId) external view returns (address);
}
