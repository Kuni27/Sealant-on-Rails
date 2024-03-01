const selectedOptions1 = {}; // Object to hold selected options for each popup
const selectedOptions2 = {}; 
const selectedOptions3 = {}; 
// Function to open the popup and set selected option
function openPopup(popupId) {
    const popup = document.getElementById(popupId);

    // Show the popup
    if (popup) {
        popup.style.display = 'block';
    }
}

// Function to save the selected option and close the popup
function closePopup(Id, popupId) {
    console.log(popupId.substring(5,6));
    
    const radioOptions = document.querySelectorAll(`input[name="radio${popupId.substring(5)}"]`);
    console.log(radioOptions);
    const cell = document.querySelector(`td[data-cell="${popupId}"]`); // Add this line to select the corresponding cell
    console.log(cell);

    // Find the selected option for the specific popup
    radioOptions.forEach(option => {
        if (option.checked) {
            // Assuming selectedOptions is declared outside this function
            if (popupId.substring(5,6) === '1'){
                selectedOptions1[Id] = option.value; // Save the selected option to the object

            cell.querySelector('.button').textContent = selectedOptions1[Id]; // Update the button text in the cell    
            }
            else if (popupId.substring(5,6) === '2'){
                selectedOptions2[Id] = option.value; // Save the selected option to the object

            cell.querySelector('.button').textContent = selectedOptions2[Id]; // Update the button text in the cell    
            }
            else if (popupId.substring(5,6) === '3'){
                selectedOptions3[Id] = option.value; // Save the selected option to the object

            cell.querySelector('.button').textContent = selectedOptions3[Id]; // Update the button text in the cell    
            }
            
        }
        
    });

    // Close the popup
    closePopupActual(popupId);
    updateUntreatedCavities();
    updatePrescribeSealant();
    updateCariesExperience();
    updateSealantPresent();
    updateRecommendedResealed();
    updateRecommendedResealedNot();
}

// Function to close the popup
function closePopupActual(popupId) {
    const popup = document.getElementById(popupId);
    if (popup) {
        popup.style.display = 'none';
    }
}