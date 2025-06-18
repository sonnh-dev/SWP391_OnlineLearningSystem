document.addEventListener('DOMContentLoaded', function () {
    // === 1. đổi màu recommend button   ===
    function initRecommend() {
        const yesBtn = document.getElementById('recommendYes');
        const noBtn = document.getElementById('recommendNo');
        const valueInput = document.getElementById('recommend');

        function set(val) {
            const isYes = val === 'yes';
            valueInput.value = val;
            yesBtn.classList.toggle('btn-success', isYes);
            yesBtn.classList.toggle('btn-outline-success', !isYes);
            noBtn.classList.toggle('btn-danger', !isYes);
            noBtn.classList.toggle('btn-outline-danger', isYes);
        }

        yesBtn.addEventListener('click', () => set('yes'));
        noBtn.addEventListener('click', () => set('no'));
    }

    // === 2. Media View Modal ===
    function initMediaModal() {
        const modal = document.getElementById('mediaModal');
        const content = document.getElementById('mediaContent');
        const caption = document.getElementById('mediaCaption');

        modal.addEventListener('show.bs.modal', function (e) {
            const btn = e.relatedTarget;
            const type = btn.getAttribute('data-type');
            const src = btn.getAttribute('data-src');
            let text = '';
            const capEl = btn.closest('.review-item')?.querySelector('.media-text');
            if (capEl)
                text = capEl.value;

            content.innerHTML = (type === 'image')
                    ? `<img src="${src}" class="modal-content" alt="Image">`
                    : `<video controls class="modal-content"><source src="${src}" type="video/mp4"></video>`;

            caption.textContent = text;
        });

        modal.addEventListener('hidden.bs.modal', () => {
            content.innerHTML = '';
            caption.textContent = '';
        });
    }

    // === 3. Upload Media & Preview ===
    let uploaded = [], captions = [];

    function initUpload() {
        const fileInput = document.getElementById('mediaUpload');
        const btn = document.getElementById('uploadMediaBtn');
        const container = document.getElementById('mediaPreviewContainer');
        const captionModal = new bootstrap.Modal(document.getElementById('mediaUploadModal'));
        const captionInput = document.getElementById('mediaCaptionInput');
        const indexInput = document.getElementById('currentMediaIndex');
        const saveBtn = document.getElementById('saveCaptionBtn');

        btn.addEventListener('click', () => {
            const files = Array.from(fileInput.files);
            if (!files.length)
                return;
            if (uploaded.length + files.length > 5) {
                alert('The maximum media can be upload is 5 files');
                return;
            }
            // Preview media
            files.forEach((file) => {
                const idx = uploaded.length;
                uploaded.push(file);
                captions.push('');

                const htmlWrapper = document.createElement('div'); //khung trong jsp
                htmlWrapper.className = 'media-preview-wrapper position-relative';
                htmlWrapper.style = 'width:180px;height:120px;border-radius:6px';
                htmlWrapper.dataset.index = idx;

                //Load preview từ file
                const reader = new FileReader();
                reader.onload = e => {
                    const isImg = file.type.startsWith('image/');
                    const img = document.createElement('img');
                    img.src = isImg ? e.target.result : 'https://cdn.pixabay.com/photo/2017/03/13/04/25/play-button-2138735_1280.png';
                    img.className = 'media-preview';
                    img.style.objectFit = 'cover';
                    //click tạo popup
                    img.addEventListener('click', () => {
                        indexInput.value = idx;
                        captionInput.value = captions[idx];
                        captionModal.show();
                    });

                    const capBox = document.createElement('div');
                    capBox.className = 'media-caption-text text-center w-100';
                    capBox.textContent = 'Click to add description';
                    capBox.style = 'position:absolute;bottom:0;background:rgba(255,255,255,0.8)';
                    //nút xóa file media
                    const rmBtn = document.createElement('span');
                    rmBtn.innerHTML = '<i class="bi bi-x-circle-fill"></i>';
                    rmBtn.style = 'position:absolute;top:5px;right:5px';
                    rmBtn.addEventListener('click', e => {
                        e.stopPropagation();
                        uploaded.splice(idx, 1);
                        captions.splice(idx, 1);
                        htmlWrapper.remove();
                        container.querySelectorAll('.media-preview-wrapper').forEach((el, i) => el.dataset.index = i);
                    });

                    htmlWrapper.append(img, capBox, rmBtn);
                    container.appendChild(htmlWrapper);
                };
                reader.readAsDataURL(file);
            });

            fileInput.value = '';
        });
        // lưu description
        saveBtn.addEventListener('click', () => {
            const idx = parseInt(indexInput.value);
            const text = captionInput.value.trim();
            captions[idx] = text;
            //cập nhật mô tả
            const box = container.querySelector(`.media-preview-wrapper[data-index="${idx}"] .media-caption-text`);
            if (box) {
                box.textContent = text || 'Click to add description';
                box.classList.toggle('text-muted', !text);
            }
            captionModal.hide();
        });
    }

    // === 4. Submit Form ===
    function initFormSubmit() {
        const courseId = document.getElementById('courseId');
        const form = document.getElementById('reviewForm');
        const recommend = document.getElementById('recommend');
        const comment = document.getElementById('comment');
        const container = document.getElementById('mediaPreviewContainer');

        form.addEventListener('submit', function (e) {
            e.preventDefault(); //chặn submit tới servlet dopost.
            //validate
            if (!recommend.value)
                return alert('Please indicate recommendation');
            if (!comment.value.trim())
                return alert('Please write a review');

            if (captions.some((c, i) => !c && uploaded[i])) {
                if (confirm('Some media lack captions. Add now?'))
                    return;
            }
            //Thiết lập formdata để gửi tới servlet
            const formData = new FormData();
            formData.append('courseId', courseId.value);
            formData.append('recommend', recommend.value);
            formData.append('comment', comment.value);
            uploaded.forEach((file, i) => {
                formData.append('mediaFiles', file);
                formData.append('mediaCaptions', captions[i] || '');
            });

            fetch(`${window.contextPath}/CourseDetail`, {method: 'POST', body: formData})
                    .then(() => {
                        alert('Review submitted!');
                        //reset form.
                        form.reset();
                        recommend.value = '';
                        uploaded = [];
                        captions = [];
                        container.innerHTML = '';
                        document.getElementById('recommendYes').classList.replace('btn-success', 'btn-outline-success');
                        document.getElementById('recommendNo').classList.replace('btn-danger', 'btn-outline-danger');
                        window.location.reload();
                    })
                    .catch(err => {
                        console.error(err);
                        alert('Error submitting review');
                    });
        });
    }

    // === Call all initializers ===
    initRecommend();
    initMediaModal();
    initUpload();
    initFormSubmit();
});