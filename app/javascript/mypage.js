document.addEventListener("turbo:load", () => {
    const modal = document.getElementById("unbookmark-modal");
    const cancelButton = document.getElementById("cancel-unbookmark");
    const unbookmarkForm = document.getElementById("unbookmark-form");

    if (!modal || !cancelButton || !unbookmarkForm) return;

    document.querySelectorAll(".unbookmark-button").forEach((button) => {
        button.addEventListener("click", () => {
            const bookmarkId = button.dataset.bookmarkId;

            unbookmarkForm.action = `/bookmarks/${bookmarkId}`;
            modal.hidden = false;
        });
    });

    cancelButton.addEventListener("click", () => {
        modal.hidden = true;
    });
});

// =====================================
// 質問削除
// =====================================

const deleteModal = document.getElementById("delete-modal");
const cancelDeleteButton = document.getElementById("cancel-delete");
const deleteForm = document.getElementById("delete-form");

if (deleteModal && cancelDeleteButton && deleteForm) {

    document.querySelectorAll(".delete-button").forEach((button) => {
        button.addEventListener("click", () => {
            const questionId = button.dataset.questionId;

            // 削除する質問のURLを設定
            deleteForm.action = `/questions/${questionId}`;

            // 確認モーダルを表示
            deleteModal.hidden = false;
        });
    });

    // キャンセルボタン
    cancelDeleteButton.addEventListener("click", () => {
        deleteModal.hidden = true;
    });
}