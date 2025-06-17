document.addEventListener('DOMContentLoaded', function () {
    const carouselEl = document.querySelector('#courseCarousel');
    const captionBox = document.getElementById('external-caption');
    const hint = document.getElementById('click-hint');
    const items = carouselEl.querySelectorAll('.carousel-item');
    const youtubeContainers = document.querySelectorAll('.youtube-container');
    const carousel = bootstrap.Carousel.getOrCreateInstance(carouselEl);
    let players = [];
    // Load YouTube IFrame API
    const tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    document.body.appendChild(tag);
    window.onYouTubeIframeAPIReady = function () {
        youtubeContainers.forEach((container, index) => {
            const videoId = container.dataset.id;
            const div = document.createElement('div');
            div.id = `yt-player-${index}`;
            container.appendChild(div);
            const player = new YT.Player(div.id, {
                videoId,
                playerVars: {
                    autoplay: 0,
                    controls: 1,
                    modestbranding: 1,
                    rel: 0,
                    playsinline: 1
                },
                events: {
                    onReady: function (event) {
                        // Gán style cho iframe khi sẵn sàng
                        const iframe = container.querySelector('iframe');
                        if (iframe) {
                            iframe.style.borderRadius = '1rem';
                            iframe.style.width = '100%';
                            iframe.style.height = '100%';
                        }
                    },
                    onStateChange: function (event) {
                        if (event.data === YT.PlayerState.PLAYING) {
                            carousel.pause(); // Dừng tự động chuyển slide
                        } else if (event.data === YT.PlayerState.ENDED) {
                            setTimeout(() => carousel.next(), 5000);
                        }
                    }
                }
            });
            players.push(player);
        });
    };
    function pauseAllVideos() {
        players.forEach(player => {
            if (player.pauseVideo)
                player.pauseVideo();
        });
    }

    function updateCaption() {
        const active = carouselEl.querySelector('.carousel-item.active');
        captionBox.innerText = active?.dataset.caption || '';
    }
    function hideDescriptions() {
        document.querySelectorAll('.description').forEach(desc => desc.style.display = 'none');
    }
// Events
    carouselEl.addEventListener('slide.bs.carousel', () => {
        pauseAllVideos();
        hideDescriptions();
    });
    carouselEl.addEventListener('slid.bs.carousel', () => {
        updateCaption();
        const active = carouselEl.querySelector('.carousel-item.active');
        const index = [...items].indexOf(active);
        const ytContainersBefore = [...items].slice(0, index).filter(i => i.querySelector('.youtube-container')).length;
        if (active.querySelector('.youtube-container')) {
            setTimeout(() => {
                players[ytContainersBefore]?.playVideo?.();
            }, 500);
        }
    });
    items.forEach(item => {
        item.addEventListener('click', e => {
            if (e.target.closest('.info-button'))
                return;
            const desc = item.querySelector('.description');
            desc.style.display = desc.style.display === 'block' ? 'none' : 'block';
            hint.style.opacity = '0';
        });
    });
    document.querySelectorAll('.info-button').forEach(btn => {
        btn.addEventListener('click', e => {
            e.stopPropagation();
            const desc = btn.closest('.carousel-item').querySelector('.description');
            desc.style.display = desc.style.display === 'block' ? 'none' : 'block';
            hint.style.opacity = '0';
        });
    });
    setTimeout(() => {
        hint.style.opacity = '0';
    }, 4000);
    updateCaption();
});