document.addEventListener('DOMContentLoaded', function () {
    const carouselEl = document.querySelector('#courseCarousel');
    const youtubeContainers = document.querySelectorAll('.youtube-container');
    const carouselItems = carouselEl.querySelectorAll('.carousel-item');

    // Bootstrap carousel config: no auto-slide
    const carousel = new bootstrap.Carousel(carouselEl, {
        interval: false,
        ride: false,
        pause: false,
        wrap: true
    });

    let players = [];
    let isVideoLocked = false;

    // Chặn chuyển slide
    carouselEl.addEventListener('slide.bs.carousel', function (e) {
        if (isVideoLocked) {
            e.preventDefault();
        }
    });

    // Load YouTube API
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
                    onReady: function () {
                        const iframe = container.querySelector('iframe');
                        if (iframe) {
                            iframe.style.borderRadius = '1rem';
                            iframe.style.width = '100%';
                            iframe.style.height = '100%';
                        }
                    },
                    onStateChange: function (event) {
                        switch (event.data) {
                            case YT.PlayerState.PLAYING:
                            case YT.PlayerState.PAUSED:
                                isVideoLocked = true;
                                break;
                            case YT.PlayerState.ENDED:
                                isVideoLocked = false;
                                break;
                        }
                    }
                }
            });
            players.push(player);
        });
    };
});
