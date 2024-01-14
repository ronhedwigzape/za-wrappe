import { defineStore } from 'pinia'
import axios from 'axios'

export const useStore = defineStore('store', {
    state: () => ({
        payments: [],
        links: [],
        refunds: [],
        users: [],
    }),
    getters: {
        getPaymentById: (state) => (id) => {
            return state.payments.find(payment => payment.id === id)
        },
        getAllPayments: (state) => {
            return state.payments
        },
        getLinkById: (state) => (id) => {
            return state.links.find(link => link.id === id)
        },
        getAllLinks: (state) => {
            return state.links
        },
        getRefundById: (state) => (id) => {
            return state.refunds.find(refund => refund.id === id)
        },
        getAllRefunds: (state) => {
            return state.refunds
        }
    },
    actions: {
        // Define a method to get headers to ensure they are evaluated at runtime
        getHeaders() {
            const secretKey = import.meta.env.VITE_PAYMONGO_SECRET_KEY;
            const base64SecretKey = btoa(secretKey + ':'); // Base64 encode the secret key
            return {
                'Content-Type': 'application/json',
                'Authorization': `Basic ${base64SecretKey}`,
            };
        },


        listenForLinkUpdates() {
            window.Echo.channel('links')
                .listen('.LinkUpdated', (event) => {
                    this.updateLink(event.link);
                });
        },

        updateLink(updatedLink) {
            const index = this.links.findIndex(link => link.id === updatedLink.id);
            if (index !== -1) {
                this.links[index] = updatedLink;
            } else {
                this.links.push(updatedLink);
            }
        },

        /************************************************************************************************
         * Creates a new payment record using the Paymongo API.
         *
         * @param {Object} paymentData - The data required to create a payment.
         *
         * This method posts payment data to the Paymongo API and adds the created payment to the `payments` array in the state.
         */
        createPayment: async (paymentData) => {
            try {
                const { data } = await axios.post('https://api.paymongo.com/v1/payments', paymentData, {
                    headers: this.getHeaders()
                });
                this.payments.push(data);
            } catch (error) {
                console.error(`Error creating payment: ${error}`);
            }
        },

        /************************************************************************************************
         * Retrieves all payment records from the Paymongo API.
         *
         * This method fetches the entire list of payments and updates the `payments` array in the state.
         */
        listAllPayments: async () => {
            try {
                const { data } = await axios.get('https://api.paymongo.com/v1/payments', {
                    headers: this.getHeaders()
                });
                this.payments.push(data);
            } catch (error) {
                console.error(`Error listing payments: ${error}`);
            }
        },

        /************************************************************************************************
         * Retrieves a specific payment by its ID from the Paymongo API.
         *
         * @param {String} id - The ID of the payment to retrieve.
         *
         * This method fetches a specific payment by ID and adds it to the `payments` array in the state.
         */
        retrievePayment: async (id) => {
            try {
                const { data } =  await axios.get(`https://api.paymongo.com/v1/payments/${id}`, {
                    headers: this.getHeaders()
                });
                this.payments.push(data);
            } catch (error) {
                console.error(`Error retrieving payment: ${error}`);
            }
        },

        /************************************************************************************************
         * Creates a new link record using the Paymongo API.
         *
         * @param {Object} linkData - The data required to create a link.
         */
        createLink: async function (linkData) {
            try {
                const { data } = await axios.post('https://api.paymongo.com/v1/links', linkData, {
                    headers: this.getHeaders()
                });
                this.links.push(data);
            } catch (error) {
                if (error.response) {
                    // The request was made and the server responded with a status code
                    // that falls out of the range of 2xx
                    console.error(error.response.data);
                    console.error(error.response.status);
                    console.error(error.response.headers);
                } else if (error.request) {
                    // The request was made but no response was received
                    console.error(error.request);
                } else {
                    // Something happened in setting up the request that triggered an Error
                    console.error('Error', error.message);
                }
            }
        },

        /************************************************************************************************
         * Retrieves all link records from the Paymongo API by reference numbers.
         */
        listAllLinks: async function () {
            const referenceNumbers = [
                'myTijiN',
                'gZuNLSQ',
                'tdiLxGK',
                'FPsc6Pj',
                'SpYF7Sd',
                'A8xN8WQ',
                'TqzyLCQ',
                '7DUbu1j',
                'oG2nEUk',
                '8svkEfL'
            ];

            try {
                // Clear the current links array
                this.links = [];

                // Fetch each link by reference number and add to the links array
                for (const reference of referenceNumbers) {
                    const response = await axios.get(`https://api.paymongo.com/v1/links?reference_number=${reference}`, {
                        headers: this.getHeaders()
                    });
                    // Assuming the response data structure is an object with a 'data' array
                    this.links.push(...response.data.data); // Use spread operator to add all links
                }
            } catch (error) {
                console.error(`Error listing links by reference numbers: ${error}`);
            }
        },

        /************************************************************************************************
         * Retrieves a specific link by its ID from the Paymongo API.
         *
         * @param {String} id - The ID of the link to retrieve.
         */
        retrieveLink: async function (id) {
            try {
                const { data } = await axios.get(`https://api.paymongo.com/v1/links/${id}`, { headers: this.getHeaders() });
                this.links.push(data);
            } catch (error) {
                console.error(`Error retrieving link: ${error}`);
            }
        },

        /************************************************************************************************
         * Retrieves a link by its reference number from the Paymongo API.
         *
         * @param {String} reference - The reference number of the link to retrieve.
         */
        getLinkByReferenceNumber: async function (reference) {
            try {
                const { data } = await axios.get(`https://api.paymongo.com/v1/links/reference/${reference}`, { headers: this.getHeaders() });
                this.links.push(data);
            } catch (error) {
                console.error(`Error getting link by reference number: ${error}`);
            }
        },

        /************************************************************************************************
         * Archives a link by its ID using the Paymongo API.
         *
         * @param {String} id - The ID of the link to archive.
         */
        archiveLink: async function (id) {
            try {
                const { data } = await axios.post(`https://api.paymongo.com/v1/links/${id}/archive`, {}, { headers: this.getHeaders() });
                this.links.push(data);
            } catch (error) {
                console.error(`Error archiving link: ${error}`);
            }
        },

        /************************************************************************************************
         * Unarchives a link by its ID using the Paymongo API.
         *
         * @param {String} id - The ID of the link to unarchive.
         */
        unarchiveLink: async function (id) {
            try {
                const { data } = await axios.post(`https://api.paymongo.com/v1/links/${id}/unarchive`, {}, { headers: this.getHeaders() });
                this.links.push(data);
            } catch (error) {
                console.error(`Error unarchiving link: ${error}`);
            }
        },

        /************************************************************************************************
         * Creates a new refund record using the Paymongo API.
         *
         * @param {Object} refundData - The data required to create a refund.
         */
        createRefund: async function (refundData) {
            try {
                const { data } = await axios.post('https://api.paymongo.com/v1/refunds', refundData, { headers: this.getHeaders() });
                this.refunds.push(data);
            } catch (error) {
                console.error(`Error creating refund: ${error}`);
            }
        },

        /************************************************************************************************
         * Retrieves a specific refund by its ID from the Paymongo API.
         *
         * @param {String} id - The ID of the refund to retrieve.
         */
        retrieveRefund: async function (id) {
            try {
                const { data } = await axios.get(`https://api.paymongo.com/v1/refunds/${id}`, { headers: this.getHeaders() });
                this.refunds.push(data);
            } catch (error) {
                console.error(`Error retrieving refund: ${error}`);
            }
        },

        /************************************************************************************************
         * Retrieves all refund records from the Paymongo API.
         */
        listAllRefunds: async function () {
            try {
                const { data } = await axios.get('https://api.paymongo.com/v1/refunds', { headers: this.getHeaders() });
                this.refunds = data;
            } catch (error) {
                console.error(`Error listing refunds: ${error}`);
            }
        },

        /************************************************************************************************
         * Generates a transaction link for each user.
         *
         * @param {Object} eventData - Data for generating the link.
         *
         * Fetches all users, generates a link for each, and adds the link to the user's links in the state.
         */
        generateLinksForAllUsers: async (eventData) => {
            try {
                // Fetch all users from your database
                const usersResponse = await axios.get('/api/users');
                this.users = usersResponse.data;

                // Generate a link for each user
                for (const user of this.users) {
                    try {
                        const linkResponse = await axios.post(`/api/users/${user.id}/generate-link`, eventData, { headers: this.getHeaders() });
                        const linkData = linkResponse.data;
                        // Add the link to the user's links array
                        user.links = user.links || []; // Initialize links array if it doesn't exist
                        user.links.push(linkData);
                    } catch (error) {
                        console.error(`Error generating link for user ${user.id}:`, error);
                    }
                }
            } catch (error) {
                console.error('Error fetching users:', error);
            }
        },

        /************************************************************************************************
         * Generates a transaction link for each user with the "student" user type.
         *
         * @param {Object} eventData - Data for generating the link.
         *
         * Fetches all users, filters by "student" user type, generates a link for each, and adds the link to the user's links in the state.
         */
        generateLinksForStudentUsers: async function (eventData) {
            try {
                // Fetch all users from your database
                const usersResponse = await axios.get('/api/users');
                this.users = usersResponse.data;

                // Filter users by "student" user type
                const studentUsers = this.users.filter(user => user.user_type === 'student');

                // Generate a link for each student user
                for (const user of studentUsers) {
                    try {
                        const linkResponse = await axios.post(`/api/users/${user.id}/generate-link`, eventData, { headers: this.getHeaders() });
                        const linkData = linkResponse.data;
                        // Add the link to the user's links array
                        user.links = user.links || []; // Initialize links array if it doesn't exist
                        user.links.push(linkData);
                    } catch (error) {
                        console.error(`Error generating link for student user ${user.id}:`, error);
                    }
                }
            } catch (error) {
                console.error('Error fetching users:', error);
            }
        },
    },
});
