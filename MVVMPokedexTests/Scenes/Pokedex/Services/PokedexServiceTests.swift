//
//  PokedexServiceTests.swift
//  MVVMPokedexTests
//
//  Created by Allan Gazola Galdino on 03/02/22.
//

import XCTest
@testable import MVVMPokedex

class PokedexServiceTests: XCTestCase {

    // MARK: - Properties

    private var sut: PokedexService!
    private var session: NetworkSessionMock!
    private var pokemonUrl = "https://pokeapi.co/api/v2/pokemon/1/"

    // MARK: - Lifecycle methods

    override func setUp() {
        session = NetworkSessionMock()
        sut = PokedexService(session: session)
    }

    override func tearDown() {
        sut = nil
        session = nil
    }

    // MARK: - Load Pokedex

    func testLoadPokedexWithNoDataShouldFailWithEmptyResponse() {
        sut.loadPokedex { result in
            switch result {
            case .success(_):
                XCTFail("There should not be a pokedex here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Empty response")
            }
        }
    }

    func testLoadPokedexWithInvalidUrlShouldFailWithInvalidUrl() {
        sut = PokedexService(apiUrl: "invalid url")

        sut.loadPokedex { result in
            switch result {
            case .success(_):
                XCTFail("There should not be a pokedex here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Invalid URL")
            }
        }
    }

    func testLoadPokedexWithNetworkErrorShouldFailWithServerError() {
        session = NetworkSessionMock(error: NetworkErrors.serverError(message: ""))
        sut = PokedexService(session: session)

        sut.loadPokedex { result in
            switch result {
            case .success(_):
                XCTFail("There should not be a pokedex here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Error returning data from the server")
            }
        }
    }

    func testLoadPokedexWithInvalidJsonShouldFailWithJsonDecodingError() {
        session = NetworkSessionMock(data: PokedexFactory.createUndecodablePokedexData())
        sut = PokedexService(session: session)

        sut.loadPokedex { result in
            switch result {
            case .success(_):
                XCTFail("There should not be a pokedex here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Could not decode JSON")
            }
        }
    }

    func testLoadPokedexWithPokedexDataShouldSuccessWithBulbasaurResultOnPokedex() {
        session = NetworkSessionMock(data: PokedexFactory.createPokedexData())
        sut = PokedexService(session: session)

        let expectedPokedex = PokedexFactory.createPokedex(withPokemonsCount: 1)

        sut.loadPokedex { result in
            switch result {
            case .success(let pokedex):
                XCTAssertEqual(pokedex.results, expectedPokedex.results)
            case .failure(let error):
                XCTFail("Load Pokedex failed with error: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Load Pokemon

    func testLoadPokemonWithInvalidUrlShouldFailWithInvalidUrl() {
        sut.loadPokemon(with: "") { result in
            switch result {
            case .success(_):
                XCTFail("There should not be a pokemon here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Invalid URL")
            }
        }
    }

    func testLoadPokemonWithNetworkErrorShouldFailWithServerError() {
        session = NetworkSessionMock(error: NetworkErrors.serverError(message: ""))
        sut = PokedexService(session: session)

        sut.loadPokemon(with: pokemonUrl) { result in
            switch result {
            case .success(_):
                XCTFail("There should not be a pokedex here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Error returning data from the server")
            }
        }
    }

    func testLoadPokemonWithNoDataShouldFailWithEmptyResponse() {
        sut.loadPokemon(with: pokemonUrl) { result in
            switch result {
            case .success(_):
                XCTFail("There should not be a pokemon here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Empty response")
            }
        }
    }

    func testLoadPokemonWithInvalidJsonShouldFailWithJsonDecodingError() {
        session = NetworkSessionMock(data: PokemonFactory.createUndecodablePokemonData())
        sut = PokedexService(session: session)

        sut.loadPokemon(with: pokemonUrl) { result in
            switch result {
            case .success(_):
                XCTFail("There should not be a pokedex here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Could not decode JSON")
            }
        }
    }

    func testLoadPokemonWithPokemonDataShouldSuccessWithBulbasaurPokemon() {
        session = NetworkSessionMock(data: PokemonFactory.createPokemonData())
        sut = PokedexService(session: session)

        let expectedResult = PokemonFactory.createPokemon()

        sut.loadPokemon(with: pokemonUrl) { result in
            switch result {
            case .success(let pokemon):
                XCTAssertEqual(pokemon, expectedResult)
            case .failure(let error):
                XCTFail("Load Pokemon failed with error: \(error.localizedDescription)")
            }
        }
    }
}
