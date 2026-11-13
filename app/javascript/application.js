// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "mypage"
import "teacher_mypage"


// 教師側：質問削除確認モーダル
if (!window.teacherDeleteModalInitialized) {
    window.teacherDeleteModalInitialized = true;
  
    let teacherDeleteForm = null;
    let teacherDeleteButton = null;
  
    const openTeacherDeleteModal = (form, button) => {
      const modal = document.getElementById("teacher-delete-modal");
      const message = document.getElementById("teacher-delete-message");
  
      if (!modal) return;
  
      teacherDeleteForm = form;
      teacherDeleteButton = button;
  
      message.textContent =
        button.dataset.deleteConfirm ||
        "この質問を削除してもよろしいですか？";
  
      modal.hidden = false;
      modal.setAttribute("aria-hidden", "false");
  
      document.getElementById("teacher-delete-cancel").focus();
    };
  
    const closeTeacherDeleteModal = () => {
      const modal = document.getElementById("teacher-delete-modal");
  
      if (!modal) return;
  
      modal.hidden = true;
      modal.setAttribute("aria-hidden", "true");
  
      if (teacherDeleteButton) {
        teacherDeleteButton.focus();
      }
  
      teacherDeleteForm = null;
      teacherDeleteButton = null;
    };
  
    // 削除フォームの送信を一度止めて確認画面を表示
    document.addEventListener("submit", (event) => {
      const form = event.target;
  
      if (!form.matches(".teacher-question-delete-form")) return;
  
      // 確認後の送信はそのまま許可
      if (form.dataset.confirmed === "true") {
        delete form.dataset.confirmed;
        return;
      }
  
      event.preventDefault();
      event.stopImmediatePropagation();
  
      openTeacherDeleteModal(form, event.submitter);
    }, true);
  
    // キャンセル
    document.addEventListener("click", (event) => {
      if (event.target.closest("#teacher-delete-cancel")) {
        closeTeacherDeleteModal();
      }
    });
  
    // 削除する
    document.addEventListener("click", (event) => {
      if (!event.target.closest("#teacher-delete-confirm")) return;
  
      if (!teacherDeleteForm) return;
  
      const form = teacherDeleteForm;
      const button = teacherDeleteButton;
  
      form.dataset.confirmed = "true";
  
      closeTeacherDeleteModal();
  
      form.requestSubmit(button);
    });
  
    // Escapeキーで閉じる
    document.addEventListener("keydown", (event) => {
      if (event.key !== "Escape") return;
  
      const modal = document.getElementById("teacher-delete-modal");
  
      if (modal && !modal.hidden) {
        closeTeacherDeleteModal();
      }
    });
  }
  