/* Full Page Background */
body {
    background: url('https://source.unsplash.com/1600x900/?technology,abstract') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Arial', sans-serif;
}

/* Card Container */
.cards {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    justify-content: center;
    padding: 40px 0;
}

/* Base Card Styles */
.cards .card {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    text-align: center;
    height: 130px;
    width: 270px;
    border-radius: 15px;
    color: white;
    font-size: 1.1em;
    font-weight: bold;
    cursor: pointer;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    position: relative;
    overflow: hidden;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
}

/* Card Backgrounds with Textures */
.cards .red {
    background: linear-gradient(45deg, #ff4b2b, #ff416c), url('https://source.unsplash.com/300x200/?red,pattern');
    background-blend-mode: overlay;
}

.cards .blue {
    background: linear-gradient(45deg, #1E90FF, #0073e6), url('https://source.unsplash.com/300x200/?blue,texture');
    background-blend-mode: overlay;
}

.cards .green {
    background: linear-gradient(45deg, #38ef7d, #11998e), url('https://source.unsplash.com/300x200/?green,design');
    background-blend-mode: overlay;
}

.cards .yellow {
    background: linear-gradient(45deg, #FFD700, #FFB400), url('https://source.unsplash.com/300x200/?yellow,abstract');
    background-blend-mode: overlay;
}

.cards .orange {
    background: linear-gradient(45deg, #ff7e5f, #ff6a00), url('https://source.unsplash.com/300x200/?orange,texture');
    background-blend-mode: overlay;
}

.cards .purple {
    background: linear-gradient(45deg, #6a11cb, #2575fc), url('https://source.unsplash.com/300x200/?purple,pattern');
    background-blend-mode: overlay;
}

/* Glow on Hover */
.cards .card:hover {
    transform: scale(1.1);
    box-shadow: 0px 10px 25px rgba(255, 255, 255, 0.3);
}

/* Subtle Overlay Effect */
.cards .card::after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.1);
    opacity: 0;
    transition: opacity 0.3s ease;
}

.cards .card:hover::after {
    opacity: 1;
}
