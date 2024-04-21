<template>
    <div class="relative flex w-full max-h-[800px] aspect-square">
        <SfScrollable
            ref="thumbsRef"
            class="items-center w-full [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]"
            direction="vertical"
            :active-index="activeIndex"
            :previous-disabled="activeIndex === 0"
            :next-disabled="activeIndex === addOns.length - 1"
            buttons-placement="floating"
        >
            <template #previousButton="defaultProps">
                <SfButton
                    v-if="!firstThumbVisible"
                    v-bind="defaultProps"
                    :disabled="activeIndex === 0"
                    class="absolute !rounded-full z-10 top-4 rotate-90 bg-white"
                    variant="secondary"
                    size="sm"
                    square
                >
                    <SfIconChevronLeft size="sm" />
                </SfButton>
            </template>
            <div
                v-for="(addOn, index) in addOns"
                :key="`${addOn.name}-${index}-thumbnail`"
                :ref="(el) => assignRef(el, index)"
                :aria-label="addOn.name"
                :aria-current="activeIndex === index"
                :class="thumbnailClass(addOn, index)"
                @click="selectAddOn(addOn, index)"
                @mouseover="activeIndex = index"
                @focus="activeIndex = index"
                class="relative type-button"
            >
                <img
                    :alt="addOn.name"
                    width="88"
                    height="88"
                    class="border border-neutral-200"
                    :src="addOn.image_url"
                    :class="{'border-2 border-green-950 opacity-50': isSelected(addOn)}"
                />
                <div
                    v-if="isSelected(addOn)"
                    class="absolute inset-0 flex justify-center items-center"
                >
                    <svg class="w-6 h-6 text-green-800" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                    </svg>
                </div>
            </div>
            <template #nextButton="defaultProps">
                <SfButton
                    v-if="!lastThumbVisible"
                    v-bind="defaultProps"
                    :disabled="activeIndex === addOns.length"
                    class="absolute !rounded-full z-10 bottom-4 rotate-90 bg-white"
                    variant="secondary"
                    size="sm"
                    square
                >
                    <SfIconChevronRight size="sm" />
                </SfButton>
            </template>
        </SfScrollable>
        <SfScrollable
            class="w-full h-full snap-x snap-mandatory [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]"
            :active-index="activeIndex"
            direction="vertical"
            wrapper-class="h-full m-auto"
            is-active-index-centered
            buttons-placement="none"
            :drag="{ containerWidth: true }"
            @on-drag-end="onDragged"
        >
            <div
                v-for="(addOn, index) in addOns"
                :key="`${addOn.name}-${index}`"
                @click="selectAddOn(addOn, index)"
                class="flex justify-center h-full basis-full shrink-0 grow snap-center relative"
            >
                <img
                    :aria-label="addOn.name"
                    :aria-hidden="activeIndex !== index"
                    class="object-cover w-auto h-full"
                    :alt="addOn.name"
                    :src="addOn.image_url"
                />
                <!-- Add-on name overlay at the bottom of the image -->
                <div class="absolute bottom-0 w-full text-center text-white bg-black bg-opacity-50 py-2">
                    {{ addOn.name }}
                </div>
            </div>
        </SfScrollable>
    </div>
</template>

<script setup>
import { ref, watch, computed } from 'vue';
import {
    SfScrollable,
    SfButton,
    SfIconChevronLeft,
    SfIconChevronRight,
} from '@storefront-ui/vue';
import { useOrderStore } from "@/Store/store-order.js";
import { useIntersectionObserver, unrefElement } from '@vueuse/core';

const props = defineProps({
    addOns: Array
});

const orderStore = useOrderStore();
const thumbsRef = ref(null);
const firstThumbRef = ref(null);
const lastThumbRef = ref(null);
const firstThumbVisible = ref(false);
const lastThumbVisible = ref(false);
const activeIndex = ref(0);

watch(
    thumbsRef,
    (newVal) => {
        if (newVal) {
            useIntersectionObserver(
                firstThumbRef,
                ([{ isIntersecting }]) => {
                    firstThumbVisible.value = isIntersecting;
                },
                {
                    root: unrefElement(thumbsRef),
                    rootMargin: '0px',
                    threshold: 1,
                },
            );
            useIntersectionObserver(
                lastThumbRef,
                ([{ isIntersecting }]) => {
                    lastThumbVisible.value = isIntersecting;
                },
                {
                    root: unrefElement(thumbsRef),
                    rootMargin: '0px',
                    threshold: 1,
                },
            );
        }
    },
    { immediate: true },
);

const onDragged = ({ swipeRight, swipeLeft }) => {
    if (swipeRight && activeIndex.value > 0) {
        activeIndex.value -= 1;
    } else if (swipeLeft && activeIndex.value < props.addOns.length - 1) {
        activeIndex.value += 1;
    }
};

const assignRef = (el, index) => {
    if (!el) return;
    if (index === props.addOns.length - 1) {
        lastThumbRef.value = el;
    } else if (index === 0) {
        firstThumbRef.value = el;
    }
};

function thumbnailClass(addOn, index) {
    return [
        'md:w-[78px] md:h-auto relative shrink-0 pb-1 mx-4 -mb-2 border-b-4 snap-start cursor-pointer focus-visible:outline focus-visible:outline-offset transition-colors flex-grow md:flex-grow-0',
        {
            'border-primary-700': activeIndex.value === index,
            'opacity-50': !addOn.active
        }
    ];
}

function selectAddOn(addOn, index) {
    orderStore.toggleAddOn(addOn);
    activeIndex.value = index;
}

const isSelected = (addOn) => {
    return orderStore.selectedAddOns.some(a => a.id === addOn.id);
}
</script>
