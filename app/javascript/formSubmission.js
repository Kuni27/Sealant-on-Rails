document.addEventListener("submit", function(event) {
    event.preventDefault();

    var popupScreening = {};
    var popupPreventative = {};
    var popupFollowup = {};
    var decayedTooth = 0;
    var sealentsPresent = 0;
    var carrriesExperience = 0;

    function handlePopupSelection(toothNumber, selectedValue, formName) {
        if (formName === "Screening") {
            popupScreening[toothNumber] = selectedValue;
        } else if (formName === "Preventative") {
            popupPreventative[toothNumber] = selectedValue;
        } else if (formName === "Followup") {
            popupFollowup[toothNumber] = selectedValue;
        }
    }

    for (var toothNumber = 1; toothNumber <= 32; toothNumber++) {
        var button = document.getElementById('ScreeningButton' + toothNumber);
        if (button) {
            var selectedValue1 = button.innerText.trim();
            selectedValue1 = selectedValue1 === "Make a Selection" ? "" : selectedValue1;
            if(selectedValue1 === "D"){
                decayedTooth ++;
            }
            if(selectedValue1 === "SS"){
                sealentsPresent++;
            }
            if(selectedValue1 === "F"){
                console.log("Entered");
                carrriesExperience++;
            }
            handlePopupSelection(toothNumber.toString(), selectedValue1, "Screening");
        }
    }
    for (var toothNumber = 1; toothNumber <= 32; toothNumber++) {
        var button = document.getElementById('PreventativeButton' + toothNumber);
        if (button) {
            var selectedValue2 = button.innerText.trim();
            selectedValue2 = selectedValue2 === "Make a Selection" ? "" : selectedValue2;
            if(selectedValue2 === "D"){
                decayedTooth ++;
            }
            if(selectedValue2 === "SS"){
                sealentsPresent++;
            }
            if(selectedValue2 === "F"){
                carrriesExperience++;
            }
            handlePopupSelection(toothNumber.toString(), selectedValue2, "Preventative");
        }
    }
    for (var toothNumber = 1; toothNumber <= 32; toothNumber++) {
        var button = document.getElementById('FollowupButton' + toothNumber);
        if (button) {
            var selectedValue3 = button.innerText.trim();
            selectedValue3 = selectedValue3 === "Make a Selection" ? "" : selectedValue3;
            if(selectedValue3 === "D"){
                decayedTooth ++;
            }
            if(selectedValue3 === "SS"){
                sealentsPresent++;
            }
            if(selectedValue3 === "F"){
                carrriesExperience++;
            }
            handlePopupSelection(toothNumber.toString(), selectedValue3, "Followup");
        }
    }
    // Repeat for Preventative and Followup

    if (event.submitter && event.submitter.id === "submitButton") {
        var form = event.target;
        var TeethScreeningStr = JSON.stringify(popupScreening);
        var TeethPreventativeStr = JSON.stringify(popupPreventative);
        var TeethFollowupStr = JSON.stringify(popupFollowup);
        var TeethScreeningInput = form.querySelector('[name="child_level_detail[TeethScreening]"]');
        var TeethPreventativeInput = form.querySelector('[name="child_level_detail[TeethPreventative]');
        var TeethFollowupInput = form.querySelector('[name="child_level_detail[TeethFollowup]');
        var DecayedTeethForm = form.querySelector('[name="child_level_detail[UntreatedCavities]');
        var SelantsPresentForm = form.querySelector('[name="child_level_detail[Sealants]"]');
        
        var CarriesExperienceForm = form.querySelector('[name="child_level_detail[CarriesExperience]"]');

        
        if (TeethScreeningInput && TeethPreventativeInput && TeethFollowupInput) {
            TeethScreeningInput.value = TeethScreeningStr;
            TeethPreventativeInput.value = TeethPreventativeStr;
            TeethFollowupInput.value = TeethFollowupStr;
            DecayedTeethForm.value = decayedTooth;
            SelantsPresentForm.value = sealentsPresent;
            CarriesExperienceForm.value = carrriesExperience;
            form.submit();
        }
    }
});
