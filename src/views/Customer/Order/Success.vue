<script setup>
import {useOrderStore} from "@/stores/store-order.js";
import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";
import ZaWrappeHeadingOne from "@/components/headers/ZaWrappeHeadingOne.vue";
import router from "@/router/index.js";

const props = defineProps({
	message: String,
	verificationCode: String,
	customerContact: String,
	orderId: Number,
	totalPrice: Number
});

const closeAndReset = () => {
	useOrderStore().orderCreated = false;
	useOrderStore().order = null;
	router.push('/customer/initialize');

};

const printReceipt = () => {
	const printContent = document.getElementById('print-section').innerHTML;
	const originalContent = document.body.innerHTML;
	document.body.innerHTML = printContent;
	window.print();
	document.body.innerHTML = originalContent;
};
</script>

<template>
	<!-- Order Success Message -->
	<transition name="fade">
		<div v-if="useOrderStore().orderCreated" class="tw-fixed tw-inset-0 tw-bg-white tw-flex tw-flex-col tw-items-center tw-justify-center tw-px-4 tw-text-center">
			<ZaWrappeLogo :height="10"/>
			<div class="tw-py-6">
				<v-icon size="x-large" class="tw-text-green-500 tw-text-7xl">mdi-check-circle</v-icon>
				<ZaWrappeHeadingOne>
					<template #title>
						Order #{{ orderId }} <p v-if="customerContact">({{ customerContact }})</p> created successfully!
					</template>
				</ZaWrappeHeadingOne>
				<p class="tw-text-xl tw-text-gray-600 tw-px-6">Your order will be sent to the kitchen, after you've completed the payment of ₱{{ totalPrice }}.</p>
			</div>
			<v-btn size="large" color="black" class="tw-mt-4 tw-text-xl" @click="closeAndReset">Okay</v-btn>
		</div>
	</transition>

	<!-- Hidden Print Section -->
	<div id="print-section" class="print-only text-center">
		<ZaWrappeLogo :height="14"/>
		<div class="!tw-mb-32 text-center">
			<h1 class="!tw-text-6xl font-weight-bold">Order #{{ orderId }}</h1>
			<p class="!tw-text-xl" v-if="customerContact">Customer Contact: {{ customerContact }}</p>
			<p class="!tw-text-lg">Verification Code: {{ verificationCode }}</p>
		</div>
		<p>----------------</p>
	</div>
</template>

<style scoped>
@media print {
	.tw-fixed, .tw-inset-0, .tw-bg-white, .tw-text-center {
		display: none !important;
	}
	.print-only {
		display: block !important;
	}
}
.print-only {
	display: none;
}
</style>
