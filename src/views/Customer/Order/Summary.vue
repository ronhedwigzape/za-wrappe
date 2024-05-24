<template>
	<transition
		name="fade"
		enter-active-class="transition-opacity duration-300 ease-out"
		leave-active-class="transition-opacity duration-300 ease-in"
		enter-from-class="opacity-0"
		enter-to-class="opacity-100"
		leave-from-class="opacity-100"
		leave-to-class="opacity-0"
	>
		<v-dialog v-if="!useOrderStore().orderCreated" max-width="500">
			<template v-slot:activator="{ props: activatorProps }">
				<v-btn
					v-bind="activatorProps"
					color="surface-variant"
					prepend-icon="mdi-check-decagram"
					text="Checkout Order"
					variant="flat"
				/>
			</template>

			<template v-slot:default="{ isActive }">
				<v-card>
					<div class="tw-flex tw-flex-col tw-items-center tw-justify-center">
						<ZaWrappeLogo :height="13"/>
					</div>
					<v-card-title class="!tw-text-2xl text-center !tw-font-bold">
						Is this order correct?
					</v-card-title>
					<v-card-text>
						<div class="scrollable-container" v-if="useOrderStore().cartVisible && useOrderStore().cart.length && useOrderStore().ordering">
							<div class="cart-content">
								<transition-group name="list" tag="ul">
									<li v-for="(item, index) in useOrderStore().cart"
										:key="item.id"
										class="tw-mt-2 tw-border-2 !tw-rounded-lg tw-border-dashed tw-border-gray-500"
									>
										<div class="tw-flex tw-flex-row tw-justify-between tw-items-center tw-border-b-2 tw-border-dashed tw-border-gray-500 tw-p-2">
											<div class="tw-font-medium tw-pr-3"> {{ item.quantity }} x {{ item.name }} (₱ {{ item.price }})</div>
											<strong class="tw-text-lg">₱ {{ (item.currentPrice).toFixed(2) }}</strong>
										</div>
										<div class="tw-py-2 tw-px-4 tw-flex tw-justify-between tw-items-center">
											<div class="tw-flex tw-flex-col">
												<small v-if="item.flavor">Flavor: <b>{{ item.flavor }}</b></small>
												<div v-if="item.addOns.length">
													<small class="">Add Ons:</small>
													<ul>
														<li class="tw-list-disc tw-ml-6" v-for="addOn in item.addOns" :key="addOn.id">
															<small><b>{{ addOn.name }}</b> (+₱{{ addOn.price }})</small>
														</li>
													</ul>
												</div>
											</div>
										</div>
									</li>
								</transition-group>
							</div>
							<div class="cart-footer tw-py-2 tw-font-bold tw-flex tw-justify-end">Total: ₱{{ parseFloat(useOrderStore().cartTotal).toFixed(2) }}</div>
						</div>
						<div class="tw-pb-6">
							<h2 class="tw-typography-label-lg tw-mb-2">Order Transaction Name (optional): </h2>
							<v-text-field
								variant="outlined"
								v-model="orderTransactionNumber"
								placeholder="Enter any name you want to be identified. e.g. 'ron'"
							/>
						</div>
					</v-card-text>
					<v-card-actions>
						<v-spacer/>
						<v-btn
							text="No"
							@click="resetForm(isActive)"
							color="red"
						/>
						<v-btn
							@click="createOrder"
							text="Yes"
							color="green"
						/>
					</v-card-actions>
				</v-card>
			</template>
		</v-dialog>
	</transition>
</template>

<script setup>
import {reactive, ref} from 'vue';
import {useOrderStore} from "@/stores/store-order.js";
import ZaWrappeLogo from "@/components/logo/ZaWrappeLogo.vue";
import ZaWrappeHeadingOne from "@/components/headers/ZaWrappeHeadingOne.vue";

const orderTransactionNumber = ref('');
const createOrder = async () => {
	try {
		await useOrderStore().createOrder(orderTransactionNumber.value);
		useOrderStore().orderCreated = true;
		orderTransactionNumber.value = '';
	} catch (error) {
		console.error('Failed to create order:', error);
		alert('Failed to process order.');
	}
};

const resetForm = (isActive) => {
	isActive.value = false;
	orderTransactionNumber.value = '';
};

</script>

<style scoped>
.scrollable-container {
	overflow-y: auto;
	max-height: 300px;
}

.scrollable-container::-webkit-scrollbar-track {
	background-color: #f0f0f0;
	border-radius: 10px;
}

.scrollable-container::-webkit-scrollbar-thumb {
	background-color: #8c8c8c;
	border-radius: 10px;
}

.scrollable-container::-webkit-scrollbar {
	width: 8px;
}

.fade-enter-active, .fade-leave-active {
	transition: opacity 0.3s ease;
}
.fade-enter, .fade-leave-to {
	opacity: 0;
}

.slide-up-enter-active, .slide-up-leave-active {
	transition: all 0.3s ease-out;
}
.slide-up-enter, .slide-up-leave-to {
	transform: translateY(20px);
	opacity: 0;
}
</style>
