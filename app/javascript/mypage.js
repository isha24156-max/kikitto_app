document.addEventListener("turbo:load", () => {
    const modal = document.getElementById("delete-modal");
    const cancelButton = document.getElementById("cancel-delete");
    const deleteForm = document.getElementById("delete-form");

    if (!modal || !cancelButton || !deleteForm) return;

    document.querySelectorAll(".delete-button").forEach((button) => {
        button.addEventListener("click", () => {
            const id = button.dataset.questionId;
    
            deleteForm.action = `/questions/${id}`;
            modal.hidden = false;
        });
        });
    
        cancelButton.addEventListener("click", () => {
        modal.hidden = true;
    });
});