document.addEventListener("turbo:load", () => {
    const menuButtons = document.querySelectorAll(
        ".teacher-menu button[data-view]"
    );
    const questionViews = document.querySelectorAll(
        ".teacher-question-view"
    );

    const pageNumbers = document.getElementById("teacher-page-numbers");
    const prevButton = document.getElementById("teacher-prev");
    const nextButton = document.getElementById("teacher-next");
    const perPage = 10;

    // タブごとのページ番号を管理
    const currentPages = {
        unanswered: 1,
        history: 1,
        all: 1
    };

    // URLのパラメータを確認
    const params = new URLSearchParams(window.location.search);

    // 削除後に質問一覧を表示
    if (params.get("view") === "all") {
        questionViews.forEach(view => {
            view.hidden = view.id !== "all";
        });

        menuButtons.forEach(button => {
            button.classList.toggle(
                "selected",
                button.dataset.view === "all"
            );
        });
    }

    // 各タブの質問をページ分割
    function renderPagination() {
        const activeView = document.querySelector(
            ".teacher-question-view:not([hidden])"
        );

        if (!activeView || !pageNumbers || !prevButton || !nextButton) {
            return;
        }

        const tbody = activeView.querySelector("tbody");
        if (!tbody) return;

        // RailsがHTMLに表示した質問行を取得
        
        const rows = Array.from(tbody.querySelectorAll("tr"))
        .filter(row => !row.classList.contains("no-questions-row"));

        if (rows.length === 0) {
        pageNumbers.innerHTML = "";
        prevButton.disabled = true;
        nextButton.disabled = true;
        return;
        }

        const totalPages = Math.ceil(rows.length / perPage);

        const viewId = activeView.id;

        currentPages[viewId] = Math.min(
            currentPages[viewId] || 1,
            totalPages
        );

        const currentPage = currentPages[viewId];
        const start = (currentPage - 1) * perPage;

        rows.forEach((row, index) => {
            row.hidden = index < start || index >= start + perPage;
        });

        // ページ番号を作成
        pageNumbers.innerHTML = "";

        for (let page = 1; page <= totalPages; page++) {
            const button = document.createElement("button");
            button.type = "button";
            button.textContent = page;

            if (page === currentPage) {
                button.classList.add("active");
            }

            button.addEventListener("click", () => {
                currentPages[viewId] = page;
                renderPagination();
            });

            pageNumbers.appendChild(button);
        }

        prevButton.disabled = currentPage === 1;
        nextButton.disabled = currentPage === totalPages;
    }

    // タブ切り替え
    menuButtons.forEach(button => {
        button.addEventListener("click", () => {
            const targetId = button.dataset.view;

            questionViews.forEach(view => {
                view.hidden = view.id !== targetId;
            });

            menuButtons.forEach(menuButton => {
                menuButton.classList.toggle(
                    "selected",
                    menuButton === button
                );
            });

            renderPagination();
        });
    });

    // 前のページ
    prevButton?.addEventListener("click", () => {
        const activeView = document.querySelector(
            ".teacher-question-view:not([hidden])"
        );

        if (!activeView) return;

        const viewId = activeView.id;
        if (currentPages[viewId] > 1) {
            currentPages[viewId]--;
            renderPagination();
        }
    });

    // 次のページ
    nextButton?.addEventListener("click", () => {
        const activeView = document.querySelector(
            ".teacher-question-view:not([hidden])"
        );

        if (!activeView) return;

        const viewId = activeView.id;
        const tbody = activeView.querySelector("tbody");
        const totalPages = Math.max(
            1,
            Math.ceil(tbody.querySelectorAll("tr").length / perPage)
        );

        if (currentPages[viewId] < totalPages) {
            currentPages[viewId]++;
            renderPagination();
        }
    });

    renderPagination();
});

// =====================================
// 先生側の質問削除モーダル
// =====================================

const teacherDeleteModal =
    document.getElementById("teacher-delete-modal");

const teacherCancelDelete =
    document.getElementById("teacher-cancel-delete");

const teacherDeleteForm =
    document.getElementById("teacher-delete-form");

if (teacherDeleteModal && teacherCancelDelete && teacherDeleteForm) {

    document.querySelectorAll(".teacher-delete-button").forEach((button) => {
        button.addEventListener("click", () => {

            const questionId = button.dataset.questionId;

            teacherDeleteForm.action = `/teacher_mypage/${questionId}`;

            teacherDeleteModal.hidden = false;
        });
    });

    teacherCancelDelete.addEventListener("click", () => {
        teacherDeleteModal.hidden = true;
    });
}