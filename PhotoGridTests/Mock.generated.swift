// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.1

import SwiftyMocky
import XCTest
import Photos
import UIKit
@testable import PhotoGrid


// MARK: - PhotoLibraryProtocol

open class PhotoLibraryProtocolMock: NSObject, PhotoLibraryProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func fetchAssets(identifiers: [String], completionHandler: @escaping (PHFetchResult<PHAsset>) -> Void) {
        addInvocation(.m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler(Parameter<[String]>.value(`identifiers`), Parameter<(PHFetchResult<PHAsset>) -> Void>.value(`completionHandler`)))
		let perform = methodPerformValue(.m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler(Parameter<[String]>.value(`identifiers`), Parameter<(PHFetchResult<PHAsset>) -> Void>.value(`completionHandler`))) as? ([String], @escaping (PHFetchResult<PHAsset>) -> Void) -> Void
		perform?(`identifiers`, `completionHandler`)
    }

    open func lastAssetFromLibrary() -> PHAsset {
        addInvocation(.m_lastAssetFromLibrary)
		let perform = methodPerformValue(.m_lastAssetFromLibrary) as? () -> Void
		perform?()
		var __value: PHAsset
		do {
		    __value = try methodReturnValue(.m_lastAssetFromLibrary).casted()
		} catch {
			onFatalFailure("Stub return value not specified for lastAssetFromLibrary(). Use given")
			Failure("Stub return value not specified for lastAssetFromLibrary(). Use given")
		}
		return __value
    }

    open func requestImage(asset: PHAsset, completionHandler: @escaping (UIImage) -> Void) {
        addInvocation(.m_requestImage__asset_assetcompletionHandler_completionHandler(Parameter<PHAsset>.value(`asset`), Parameter<(UIImage) -> Void>.value(`completionHandler`)))
		let perform = methodPerformValue(.m_requestImage__asset_assetcompletionHandler_completionHandler(Parameter<PHAsset>.value(`asset`), Parameter<(UIImage) -> Void>.value(`completionHandler`))) as? (PHAsset, @escaping (UIImage) -> Void) -> Void
		perform?(`asset`, `completionHandler`)
    }

    open func deleteAsset(identifier: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        addInvocation(.m_deleteAsset__identifier_identifiercompletionHandler_completionHandler(Parameter<String>.value(`identifier`), Parameter<(Result<Bool, Error>) -> Void>.value(`completionHandler`)))
		let perform = methodPerformValue(.m_deleteAsset__identifier_identifiercompletionHandler_completionHandler(Parameter<String>.value(`identifier`), Parameter<(Result<Bool, Error>) -> Void>.value(`completionHandler`))) as? (String, @escaping (Result<Bool, Error>) -> Void) -> Void
		perform?(`identifier`, `completionHandler`)
    }

    open func emptyAssetsArray() -> [PHAsset] {
        addInvocation(.m_emptyAssetsArray)
		let perform = methodPerformValue(.m_emptyAssetsArray) as? () -> Void
		perform?()
		var __value: [PHAsset]
		do {
		    __value = try methodReturnValue(.m_emptyAssetsArray).casted()
		} catch {
			onFatalFailure("Stub return value not specified for emptyAssetsArray(). Use given")
			Failure("Stub return value not specified for emptyAssetsArray(). Use given")
		}
		return __value
    }

    open func saveImageToLibrary(image: UIImage, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        addInvocation(.m_saveImageToLibrary__image_imagecompletionHandler_completionHandler(Parameter<UIImage>.value(`image`), Parameter<(Result<UIImage, Error>) -> Void>.value(`completionHandler`)))
		let perform = methodPerformValue(.m_saveImageToLibrary__image_imagecompletionHandler_completionHandler(Parameter<UIImage>.value(`image`), Parameter<(Result<UIImage, Error>) -> Void>.value(`completionHandler`))) as? (UIImage, @escaping (Result<UIImage, Error>) -> Void) -> Void
		perform?(`image`, `completionHandler`)
    }


    fileprivate enum MethodType {
        case m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler(Parameter<[String]>, Parameter<(PHFetchResult<PHAsset>) -> Void>)
        case m_lastAssetFromLibrary
        case m_requestImage__asset_assetcompletionHandler_completionHandler(Parameter<PHAsset>, Parameter<(UIImage) -> Void>)
        case m_deleteAsset__identifier_identifiercompletionHandler_completionHandler(Parameter<String>, Parameter<(Result<Bool, Error>) -> Void>)
        case m_emptyAssetsArray
        case m_saveImageToLibrary__image_imagecompletionHandler_completionHandler(Parameter<UIImage>, Parameter<(Result<UIImage, Error>) -> Void>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler(let lhsIdentifiers, let lhsCompletionhandler), .m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler(let rhsIdentifiers, let rhsCompletionhandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIdentifiers, rhs: rhsIdentifiers, with: matcher), lhsIdentifiers, rhsIdentifiers, "identifiers"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletionhandler, rhs: rhsCompletionhandler, with: matcher), lhsCompletionhandler, rhsCompletionhandler, "completionHandler"))
				return Matcher.ComparisonResult(results)

            case (.m_lastAssetFromLibrary, .m_lastAssetFromLibrary): return .match

            case (.m_requestImage__asset_assetcompletionHandler_completionHandler(let lhsAsset, let lhsCompletionhandler), .m_requestImage__asset_assetcompletionHandler_completionHandler(let rhsAsset, let rhsCompletionhandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAsset, rhs: rhsAsset, with: matcher), lhsAsset, rhsAsset, "asset"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletionhandler, rhs: rhsCompletionhandler, with: matcher), lhsCompletionhandler, rhsCompletionhandler, "completionHandler"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteAsset__identifier_identifiercompletionHandler_completionHandler(let lhsIdentifier, let lhsCompletionhandler), .m_deleteAsset__identifier_identifiercompletionHandler_completionHandler(let rhsIdentifier, let rhsCompletionhandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIdentifier, rhs: rhsIdentifier, with: matcher), lhsIdentifier, rhsIdentifier, "identifier"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletionhandler, rhs: rhsCompletionhandler, with: matcher), lhsCompletionhandler, rhsCompletionhandler, "completionHandler"))
				return Matcher.ComparisonResult(results)

            case (.m_emptyAssetsArray, .m_emptyAssetsArray): return .match

            case (.m_saveImageToLibrary__image_imagecompletionHandler_completionHandler(let lhsImage, let lhsCompletionhandler), .m_saveImageToLibrary__image_imagecompletionHandler_completionHandler(let rhsImage, let rhsCompletionhandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsImage, rhs: rhsImage, with: matcher), lhsImage, rhsImage, "image"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletionhandler, rhs: rhsCompletionhandler, with: matcher), lhsCompletionhandler, rhsCompletionhandler, "completionHandler"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler(p0, p1): return p0.intValue + p1.intValue
            case .m_lastAssetFromLibrary: return 0
            case let .m_requestImage__asset_assetcompletionHandler_completionHandler(p0, p1): return p0.intValue + p1.intValue
            case let .m_deleteAsset__identifier_identifiercompletionHandler_completionHandler(p0, p1): return p0.intValue + p1.intValue
            case .m_emptyAssetsArray: return 0
            case let .m_saveImageToLibrary__image_imagecompletionHandler_completionHandler(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler: return ".fetchAssets(identifiers:completionHandler:)"
            case .m_lastAssetFromLibrary: return ".lastAssetFromLibrary()"
            case .m_requestImage__asset_assetcompletionHandler_completionHandler: return ".requestImage(asset:completionHandler:)"
            case .m_deleteAsset__identifier_identifiercompletionHandler_completionHandler: return ".deleteAsset(identifier:completionHandler:)"
            case .m_emptyAssetsArray: return ".emptyAssetsArray()"
            case .m_saveImageToLibrary__image_imagecompletionHandler_completionHandler: return ".saveImageToLibrary(image:completionHandler:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func lastAssetFromLibrary(willReturn: PHAsset...) -> MethodStub {
            return Given(method: .m_lastAssetFromLibrary, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func emptyAssetsArray(willReturn: [PHAsset]...) -> MethodStub {
            return Given(method: .m_emptyAssetsArray, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func lastAssetFromLibrary(willProduce: (Stubber<PHAsset>) -> Void) -> MethodStub {
            let willReturn: [PHAsset] = []
			let given: Given = { return Given(method: .m_lastAssetFromLibrary, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (PHAsset).self)
			willProduce(stubber)
			return given
        }
        public static func emptyAssetsArray(willProduce: (Stubber<[PHAsset]>) -> Void) -> MethodStub {
            let willReturn: [[PHAsset]] = []
			let given: Given = { return Given(method: .m_emptyAssetsArray, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([PHAsset]).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetchAssets(identifiers: Parameter<[String]>, completionHandler: Parameter<(PHFetchResult<PHAsset>) -> Void>) -> Verify { return Verify(method: .m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler(`identifiers`, `completionHandler`))}
        public static func lastAssetFromLibrary() -> Verify { return Verify(method: .m_lastAssetFromLibrary)}
        public static func requestImage(asset: Parameter<PHAsset>, completionHandler: Parameter<(UIImage) -> Void>) -> Verify { return Verify(method: .m_requestImage__asset_assetcompletionHandler_completionHandler(`asset`, `completionHandler`))}
        public static func deleteAsset(identifier: Parameter<String>, completionHandler: Parameter<(Result<Bool, Error>) -> Void>) -> Verify { return Verify(method: .m_deleteAsset__identifier_identifiercompletionHandler_completionHandler(`identifier`, `completionHandler`))}
        public static func emptyAssetsArray() -> Verify { return Verify(method: .m_emptyAssetsArray)}
        public static func saveImageToLibrary(image: Parameter<UIImage>, completionHandler: Parameter<(Result<UIImage, Error>) -> Void>) -> Verify { return Verify(method: .m_saveImageToLibrary__image_imagecompletionHandler_completionHandler(`image`, `completionHandler`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetchAssets(identifiers: Parameter<[String]>, completionHandler: Parameter<(PHFetchResult<PHAsset>) -> Void>, perform: @escaping ([String], @escaping (PHFetchResult<PHAsset>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_fetchAssets__identifiers_identifierscompletionHandler_completionHandler(`identifiers`, `completionHandler`), performs: perform)
        }
        public static func lastAssetFromLibrary(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_lastAssetFromLibrary, performs: perform)
        }
        public static func requestImage(asset: Parameter<PHAsset>, completionHandler: Parameter<(UIImage) -> Void>, perform: @escaping (PHAsset, @escaping (UIImage) -> Void) -> Void) -> Perform {
            return Perform(method: .m_requestImage__asset_assetcompletionHandler_completionHandler(`asset`, `completionHandler`), performs: perform)
        }
        public static func deleteAsset(identifier: Parameter<String>, completionHandler: Parameter<(Result<Bool, Error>) -> Void>, perform: @escaping (String, @escaping (Result<Bool, Error>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_deleteAsset__identifier_identifiercompletionHandler_completionHandler(`identifier`, `completionHandler`), performs: perform)
        }
        public static func emptyAssetsArray(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_emptyAssetsArray, performs: perform)
        }
        public static func saveImageToLibrary(image: Parameter<UIImage>, completionHandler: Parameter<(Result<UIImage, Error>) -> Void>, perform: @escaping (UIImage, @escaping (Result<UIImage, Error>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_saveImageToLibrary__image_imagecompletionHandler_completionHandler(`image`, `completionHandler`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - PhotoStoreProtocol

open class PhotoStoreProtocolMock: PhotoStoreProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getAllPhotos() {
        addInvocation(.m_getAllPhotos)
		let perform = methodPerformValue(.m_getAllPhotos) as? () -> Void
		perform?()
    }

    open func saveImage(image: UIImage, identifier: String?) {
        addInvocation(.m_saveImage__image_imageidentifier_identifier(Parameter<UIImage>.value(`image`), Parameter<String?>.value(`identifier`)))
		let perform = methodPerformValue(.m_saveImage__image_imageidentifier_identifier(Parameter<UIImage>.value(`image`), Parameter<String?>.value(`identifier`))) as? (UIImage, String?) -> Void
		perform?(`image`, `identifier`)
    }

    open func getLatestAssetFromLibrary() -> PHAsset {
        addInvocation(.m_getLatestAssetFromLibrary)
		let perform = methodPerformValue(.m_getLatestAssetFromLibrary) as? () -> Void
		perform?()
		var __value: PHAsset
		do {
		    __value = try methodReturnValue(.m_getLatestAssetFromLibrary).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getLatestAssetFromLibrary(). Use given")
			Failure("Stub return value not specified for getLatestAssetFromLibrary(). Use given")
		}
		return __value
    }

    open func makePhoto(identifier: String, image: UIImage) -> Photo {
        addInvocation(.m_makePhoto__identifier_identifierimage_image(Parameter<String>.value(`identifier`), Parameter<UIImage>.value(`image`)))
		let perform = methodPerformValue(.m_makePhoto__identifier_identifierimage_image(Parameter<String>.value(`identifier`), Parameter<UIImage>.value(`image`))) as? (String, UIImage) -> Void
		perform?(`identifier`, `image`)
		var __value: Photo
		do {
		    __value = try methodReturnValue(.m_makePhoto__identifier_identifierimage_image(Parameter<String>.value(`identifier`), Parameter<UIImage>.value(`image`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for makePhoto(identifier: String, image: UIImage). Use given")
			Failure("Stub return value not specified for makePhoto(identifier: String, image: UIImage). Use given")
		}
		return __value
    }

    open func saveImageIdentifierToUserDefaults(identifier: String) {
        addInvocation(.m_saveImageIdentifierToUserDefaults__identifier_identifier(Parameter<String>.value(`identifier`)))
		let perform = methodPerformValue(.m_saveImageIdentifierToUserDefaults__identifier_identifier(Parameter<String>.value(`identifier`))) as? (String) -> Void
		perform?(`identifier`)
    }

    open func getImageIdentifiersFromUserDefaults() {
        addInvocation(.m_getImageIdentifiersFromUserDefaults)
		let perform = methodPerformValue(.m_getImageIdentifiersFromUserDefaults) as? () -> Void
		perform?()
    }

    open func deletePhoto(id: String) {
        addInvocation(.m_deletePhoto__id_id(Parameter<String>.value(`id`)))
		let perform = methodPerformValue(.m_deletePhoto__id_id(Parameter<String>.value(`id`))) as? (String) -> Void
		perform?(`id`)
    }


    fileprivate enum MethodType {
        case m_getAllPhotos
        case m_saveImage__image_imageidentifier_identifier(Parameter<UIImage>, Parameter<String?>)
        case m_getLatestAssetFromLibrary
        case m_makePhoto__identifier_identifierimage_image(Parameter<String>, Parameter<UIImage>)
        case m_saveImageIdentifierToUserDefaults__identifier_identifier(Parameter<String>)
        case m_getImageIdentifiersFromUserDefaults
        case m_deletePhoto__id_id(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getAllPhotos, .m_getAllPhotos): return .match

            case (.m_saveImage__image_imageidentifier_identifier(let lhsImage, let lhsIdentifier), .m_saveImage__image_imageidentifier_identifier(let rhsImage, let rhsIdentifier)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsImage, rhs: rhsImage, with: matcher), lhsImage, rhsImage, "image"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIdentifier, rhs: rhsIdentifier, with: matcher), lhsIdentifier, rhsIdentifier, "identifier"))
				return Matcher.ComparisonResult(results)

            case (.m_getLatestAssetFromLibrary, .m_getLatestAssetFromLibrary): return .match

            case (.m_makePhoto__identifier_identifierimage_image(let lhsIdentifier, let lhsImage), .m_makePhoto__identifier_identifierimage_image(let rhsIdentifier, let rhsImage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIdentifier, rhs: rhsIdentifier, with: matcher), lhsIdentifier, rhsIdentifier, "identifier"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsImage, rhs: rhsImage, with: matcher), lhsImage, rhsImage, "image"))
				return Matcher.ComparisonResult(results)

            case (.m_saveImageIdentifierToUserDefaults__identifier_identifier(let lhsIdentifier), .m_saveImageIdentifierToUserDefaults__identifier_identifier(let rhsIdentifier)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIdentifier, rhs: rhsIdentifier, with: matcher), lhsIdentifier, rhsIdentifier, "identifier"))
				return Matcher.ComparisonResult(results)

            case (.m_getImageIdentifiersFromUserDefaults, .m_getImageIdentifiersFromUserDefaults): return .match

            case (.m_deletePhoto__id_id(let lhsId), .m_deletePhoto__id_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getAllPhotos: return 0
            case let .m_saveImage__image_imageidentifier_identifier(p0, p1): return p0.intValue + p1.intValue
            case .m_getLatestAssetFromLibrary: return 0
            case let .m_makePhoto__identifier_identifierimage_image(p0, p1): return p0.intValue + p1.intValue
            case let .m_saveImageIdentifierToUserDefaults__identifier_identifier(p0): return p0.intValue
            case .m_getImageIdentifiersFromUserDefaults: return 0
            case let .m_deletePhoto__id_id(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getAllPhotos: return ".getAllPhotos()"
            case .m_saveImage__image_imageidentifier_identifier: return ".saveImage(image:identifier:)"
            case .m_getLatestAssetFromLibrary: return ".getLatestAssetFromLibrary()"
            case .m_makePhoto__identifier_identifierimage_image: return ".makePhoto(identifier:image:)"
            case .m_saveImageIdentifierToUserDefaults__identifier_identifier: return ".saveImageIdentifierToUserDefaults(identifier:)"
            case .m_getImageIdentifiersFromUserDefaults: return ".getImageIdentifiersFromUserDefaults()"
            case .m_deletePhoto__id_id: return ".deletePhoto(id:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getLatestAssetFromLibrary(willReturn: PHAsset...) -> MethodStub {
            return Given(method: .m_getLatestAssetFromLibrary, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func makePhoto(identifier: Parameter<String>, image: Parameter<UIImage>, willReturn: Photo...) -> MethodStub {
            return Given(method: .m_makePhoto__identifier_identifierimage_image(`identifier`, `image`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getLatestAssetFromLibrary(willProduce: (Stubber<PHAsset>) -> Void) -> MethodStub {
            let willReturn: [PHAsset] = []
			let given: Given = { return Given(method: .m_getLatestAssetFromLibrary, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (PHAsset).self)
			willProduce(stubber)
			return given
        }
        public static func makePhoto(identifier: Parameter<String>, image: Parameter<UIImage>, willProduce: (Stubber<Photo>) -> Void) -> MethodStub {
            let willReturn: [Photo] = []
			let given: Given = { return Given(method: .m_makePhoto__identifier_identifierimage_image(`identifier`, `image`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Photo).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getAllPhotos() -> Verify { return Verify(method: .m_getAllPhotos)}
        public static func saveImage(image: Parameter<UIImage>, identifier: Parameter<String?>) -> Verify { return Verify(method: .m_saveImage__image_imageidentifier_identifier(`image`, `identifier`))}
        public static func getLatestAssetFromLibrary() -> Verify { return Verify(method: .m_getLatestAssetFromLibrary)}
        public static func makePhoto(identifier: Parameter<String>, image: Parameter<UIImage>) -> Verify { return Verify(method: .m_makePhoto__identifier_identifierimage_image(`identifier`, `image`))}
        public static func saveImageIdentifierToUserDefaults(identifier: Parameter<String>) -> Verify { return Verify(method: .m_saveImageIdentifierToUserDefaults__identifier_identifier(`identifier`))}
        public static func getImageIdentifiersFromUserDefaults() -> Verify { return Verify(method: .m_getImageIdentifiersFromUserDefaults)}
        public static func deletePhoto(id: Parameter<String>) -> Verify { return Verify(method: .m_deletePhoto__id_id(`id`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getAllPhotos(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getAllPhotos, performs: perform)
        }
        public static func saveImage(image: Parameter<UIImage>, identifier: Parameter<String?>, perform: @escaping (UIImage, String?) -> Void) -> Perform {
            return Perform(method: .m_saveImage__image_imageidentifier_identifier(`image`, `identifier`), performs: perform)
        }
        public static func getLatestAssetFromLibrary(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getLatestAssetFromLibrary, performs: perform)
        }
        public static func makePhoto(identifier: Parameter<String>, image: Parameter<UIImage>, perform: @escaping (String, UIImage) -> Void) -> Perform {
            return Perform(method: .m_makePhoto__identifier_identifierimage_image(`identifier`, `image`), performs: perform)
        }
        public static func saveImageIdentifierToUserDefaults(identifier: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_saveImageIdentifierToUserDefaults__identifier_identifier(`identifier`), performs: perform)
        }
        public static func getImageIdentifiersFromUserDefaults(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getImageIdentifiersFromUserDefaults, performs: perform)
        }
        public static func deletePhoto(id: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_deletePhoto__id_id(`id`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

