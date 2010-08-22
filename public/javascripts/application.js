// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* find all the inputs,
 * for each input
 * read the attributes
 * and bind the input field to the corresponding live validation function
 */
function initialize() {
    var textInputs = selectInputElements();
    var validationType, validationOptions;
    for (var i = 0; i < textInputs.length; i++) {
	validationOptions = getValidationAttributes(textInputs[i]);
	validationType = textInputs[i].getAttribute("validation");
	bindInputElements(textInputs[i], validationType, validationOptions);
    }
}

function selectInputElements() {
    var inputElements = document.getElementsByTagName('input');
    var textInputs = new Array;
    for (var i = 0; i < inputElements.length; i++) {
	var element = inputElements[i];
	var inputType = element.getAttribute("type");
	if (inputType == "text") {
	    textInputs.push(inputElements[i]);
	}
    }
    return textInputs;    
}

function getValidationAttributes(element) {
    var validationOptions = {};
    var elementAttributes = element.attributes;
    var validationKey, validationValue;
    for(var i = 0; i < elementAttributes.length; i++) {
	validationKey = extractValidationKey(elementAttributes[i].name);
	validationValue = elementAttributes[i].value;
	if (validationKey != null) {
	    validationOptions[validationKey] = validationValue;
	}
    }
    return validationOptions;
}

function extractValidationKey(key) {
    var namespaceRegex = /validation_(\w+)/;
    var result = key.match(namespaceRegex);
    return result != null ? result[1] : null;
}

function bindInputElements(element, validation, options) {
    var elementValidation = new LiveValidation(element);
    
    switch(validation) {
    case "validates_acceptance_of":
	elementValidation.add(Validate.Acceptance, {failureMessage: options["message"]});
	break;
    case "validates_confirmation_of":
	elementValidation.add(Validate.Confirmation, {match: options[""], failureMessage: options["message"]});
	break;
    case "validates_exclusion_of":
	elementValidation.add(Validate.Exclusion, {within: options["in"], allowNull: options["allow_nil"], failureMessage: options["message"]});
	break;
    case "validates_format_of":
	elementValidation.add(Validate.Format, {pattern: new RegExp(options["with"]), failureMessage: options["message"]});
	break;
    case "validates_inclusion_of":
	elementValidation.add(Validate.Inclusion, {within: options["with"], allowNull: options["allow_nil"], failureMessage: options["message"]});
	break;
    case "validates_size_of":
    case "validates_length_of":
	elementValidation.add(Validate.Length, {is: options["is"], minimum: options["minimum"], maximum: options["maximum"], wrongLengthMessage: options["wrong_length"], tooShortMessage: options["too_short"], tooLongMessage: options["too_long"]});
	break;
    case "validates_numericality_of":
	elementValidation.add(Validate.Numericality, {is: options["equal_to"], minimum: options["greater_than_or_equal_to"], maximum: options["less_than_or_equal_to"], onlyinteger: options["only_integer"], failureMessage: options["message"]});
	break;
    case "validates_presence_of":
	elementValidation.add(Validate.Presence, {failureMessage: options["message"]});
	break;
    case "validates_uniqueness_of":
	break;
    case "validates_each":
	break;
    case "validates_associated":
	break;
    }
}