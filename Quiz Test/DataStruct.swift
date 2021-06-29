public enum typeObject {
    case checkType
    case textType
    case switchType
}

struct Questions {
    let textLabel : String
    let typeAnswer : typeObject
    let questionsArray : [String]
    let trueAnswer : String
}
