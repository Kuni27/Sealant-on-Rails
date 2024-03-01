function updateUntreatedCavities() {
    let untreatedCavitiesCount = 0;

    for (const tooth in selectedOptions1) {
        if (selectedOptions1[tooth] === 'D') {
            untreatedCavitiesCount++;
        }
    }

    const untreatedCavitiesElement = document.getElementById('untreatedCavities');

    // Update the "Untreated Cavities" field
    untreatedCavitiesElement.textContent = untreatedCavitiesCount;
}

function updatePrescribeSealant() {
    let PrescribeSealantCount = 0;

    for (const tooth in selectedOptions1) {
        if (selectedOptions1[tooth] === 'PS') {
            PrescribeSealantCount++;
        }
    }

    const prescribeSealantElement = document.getElementById('prescribeSealant');

    // Update the "Untreated Cavities" field
    prescribeSealantElement.textContent = prescribeSealantCount;
}

function updateCariesExperience() {
    let CariesExperienceCount = 0;

    for (const tooth in selectedOptions1) {
        if (selectedOptions1[tooth] === 'F') {
            CariesExperienceCount++;
        }
    }

    const cariesExperienceElement = document.getElementById('cariesExperience');

    // Update the "Untreated Cavities" field
    cariesExperienceElement.textContent = CariesExperienceCount;
}

function updateSealantPresent() {
    let SealantPresentCount = 0;

    for (const tooth in selectedOptions1) {
        if (selectedOptions1[tooth] === 'SS') {
            SealantPresentCount++;
        }
    }

    const sealantPresentElement = document.getElementById('sealantPresent');

    // Update the "Untreated Cavities" field
    sealantPresentElement.textContent = SealantPresentCount;
}

function updateRecommendedResealed() {
    let RecommendedResealedCount = 0;

    for (const tooth in selectedOptions1) {
        if (selectedOptions1[tooth] === 'RSD') {
            RecommendedResealedCount++;
        }
    }

    const recommendedResealedElement = document.getElementById('recommendedResealed');

    // Update the "Untreated Cavities" field
    recommendedResealedElement.textContent = RecommendedResealedCount;
}

function updateRecommendedResealedNot() {
    let RecommendedResealedNotCount = 0;

    for (const tooth in selectedOptions1) {
        if (selectedOptions1[tooth] === 'RSND') {
            RecommendedResealedNotCount++;
        }
    }

    const recommendedResealedNotElement = document.getElementById('recommendedResealedNot');

    // Update the "Untreated Cavities" field
    recommendedResealedNotElement.textContent = RecommendedResealedNotCount;
}