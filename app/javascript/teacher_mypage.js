
document.addEventListener("turbo:load", () => {
    const menuButtons = document.querySelectorAll(
        ".teacher-menu button[data-view]"
    );
    const questionViews = document.querySelectorAll(
        ".teacher-question-view"
    );

    // メニューの切り替え
    menuButtons.forEach((button) => {
        button.addEventListener("click", () => {
            const targetId = button.dataset.view;

            questionViews.forEach((view) => {
                view.hidden = view.id !== targetId;
            });

            menuButtons.forEach((menuButton) => {
                menuButton.classList.toggle(
                    "selected",
                    menuButton === button
                );
            });

            currentPage = 1;
            renderPagination();
        });
    });

    // 仮の質問データ（あとでデータベースの質問に置き換える）
    const questions = Array.from({ length: 25 }, (_, index) => ({
        date: `2026/10/${String(index + 1).padStart(2, "0")}`,
        content: `質問サンプル ${index + 1}`
    }));

    const perPage = 10;
    let currentPage = 1;

    const pageNumbers = document.getElementById("teacher-page-numbers");
    const prevButton = document.getElementById("teacher-prev");
    const nextButton = document.getElementById("teacher-next");

    function renderPagination() {
        const activeView = document.querySelector(
            ".teacher-question-view:not([hidden])"
        );

        if (!activeView || !pageNumbers) return;

        const tbody = activeView.querySelector("tbody");
        const totalPages = Math.max(
            1,
            Math.ceil(questions.length / perPage)
        );

        currentPage = Math.min(currentPage, totalPages);

        const start = (currentPage - 1) * perPage;
        const pageQuestions = questions.slice(start, start + perPage);

        tbody.innerHTML = "";

        pageQuestions.forEach((question) => {
            const tr = document.createElement("tr");
        
            // 現在表示している画面
            const activeView = document.querySelector(
                ".teacher-question-view:not([hidden])"
            );
        
            // 質問一覧だけごみ箱を表示する
            if (activeView.id === "all") {
                tr.innerHTML = `
                    <td>${question.date}</td>
                    <td>${question.content}</td>
                    <td>
                        <button type="button"
                                class="teacher-delete-button"
                                aria-label="質問を削除">
                                <svg xmlns="http://www.w3.org/2000/svg"
                                    width="28" height="28"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="red"
                                    stroke-width="1.8"
                                    stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <path d="M3 6h18"/>
                                    <path d="M8 6V4h8v2"/>
                                    <path d="M19 6l-1 14H6L5 6"/>
                                    <path d="M10 11v5M14 11v5"/>
                                </svg>
                            </button>
                        </td>
                    `;
                } else {
                    // 未回答・回答履歴は2列だけ
                    tr.innerHTML = `
                        <td>${question.date}</td>
                        <td>${question.content}</td>
                    `;
                }
            
                tbody.appendChild(tr);
            });

        pageNumbers.innerHTML = "";

        for (let page = 1; page <= totalPages; page++) {
            const button = document.createElement("button");
            button.type = "button";
            button.textContent = page;

            if (page === currentPage) {
                button.classList.add("active");
            }

            button.addEventListener("click", () => {
                currentPage = page;
                renderPagination();
            });

            pageNumbers.appendChild(button);
        }

        prevButton.disabled = currentPage === 1;
        nextButton.disabled = currentPage === totalPages;
    }

    prevButton?.addEventListener("click", () => {
        if (currentPage > 1) {
            currentPage--;
            renderPagination();
        }
    });

    nextButton?.addEventListener("click", () => {
        const totalPages = Math.max(
            1,
            Math.ceil(questions.length / perPage)
        );

        if (currentPage < totalPages) {
            currentPage++;
            renderPagination();
        }
    });

    renderPagination();
});
